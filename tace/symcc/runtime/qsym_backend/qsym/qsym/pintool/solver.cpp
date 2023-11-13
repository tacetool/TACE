#include <set>
#include <deque>
#include <byteswap.h>
#include "solver.h"

namespace qsym {

namespace {

const uint64_t kUsToS = 1000000;
const int kSessionIdLength = 32;
const unsigned kSolverTimeout = 10000; // 10 seconds

std::string toString6digit(INT32 val) {
  char buf[6 + 1]; // ndigit + 1
  snprintf(buf, 7, "%06d", val);
  buf[6] = '\0';
  return std::string(buf);
}

uint64_t getTimeStamp() {
  struct timeval tv;
  gettimeofday(&tv, NULL);
  return tv.tv_sec * kUsToS + tv.tv_usec;
}

void parseConstSym(ExprRef e, Kind &op, ExprRef& expr_sym, ExprRef& expr_const) {
  for (INT32 i = 0; i < 2; i++) {
    expr_sym = e->getChild(i);
    expr_const = e->getChild(1 - i);
    if (!isConstant(expr_sym)
        && isConstant(expr_const)) {
      op = i == 0 ? e->kind() : swapKind(e->kind());
      return;
    }
  }
  UNREACHABLE();
}

void getCanonicalExpr(ExprRef e,
    ExprRef* canonical,
    llvm::APInt* adjustment=NULL) {
  ExprRef first = NULL;
  ExprRef second = NULL;
  // e == Const + Sym --> canonical == Sym
  switch (e->kind()) {
    // TODO: handle Sub
    case Add:
      first = e->getFirstChild();
      second = e->getSecondChild();
      if (isConstant(first)) {
        *canonical = second;
        if (adjustment != NULL)
          *adjustment =
            static_pointer_cast<ConstantExpr>(first)->value();
        return;
      case Sub:
        // C_0 - Sym
        first = e->getFirstChild();
        second = e->getSecondChild();
        // XXX: need to handle reference count
        if (isConstant(first)) {
          *canonical = g_expr_builder->createNeg(second);
          if (adjustment != NULL)
            *adjustment = static_pointer_cast<ConstantExpr>(first)->value();
          return;
        }
      }
    default:
      break;
  }
  if (adjustment != NULL)
    *adjustment = llvm::APInt(e->bits(), 0);
  *canonical = e;
}

inline bool isEqual(ExprRef e, bool taken) {
  return (e->kind() == Equal && taken) ||
    (e->kind() == Distinct && !taken);
}

} // namespace

Solver::Solver(
    const std::string input_file,
    const std::string out_dir,
    const std::string bitmap)
  : input_file_(input_file)
  , inputs_()
  , out_dir_(out_dir)
  , context_(*g_z3_context)
  , solver_(z3::solver(context_, "QF_BV"))
  , num_generated_(0)
  , trace_(bitmap)
  , last_interested_(false)
  , syncing_(false)
  , start_time_(getTimeStamp())
  , solving_time_(0)
  , last_pc_(0)
  , dep_forest_()
{
  // Set timeout for solver
  z3::params p(context_);
  p.set(":timeout", kSolverTimeout);
  solver_.set(p);

  checkOutDir();
  readInput();
}

void Solver::push() {
  solver_.push();
}

void Solver::reset() {
  solver_.reset();
}

void Solver::pop() {
  solver_.pop();
}

void Solver::add(z3::expr expr) {
  if (!expr.is_const())
    solver_.add(expr.simplify());
}

z3::check_result Solver::check() {
  uint64_t before = getTimeStamp();
  z3::check_result res;
  // LOG_STAT(
  //     "SMT: { \"total_solving_time\": " + decstr(solving_time_) + ", "
  //     + "\"total_time\": " + decstr(before - start_time_) + " }\n");
  // // LOG_DEBUG("Constraints: " + solver_.to_smt2() + "\n");
  try {
    res = solver_.check();
  }
  catch(z3::exception e) {
    // https://github.com/Z3Prover/z3/issues/419
    // timeout can cause exception
    res = z3::unknown;
  }
  uint64_t cur = getTimeStamp();
  uint64_t elapsed = cur - before;
  solving_time_ += elapsed;
  LOG_STAT("SMT: {\"solving_time_elapsed\": " + decstr(elapsed) + " }\n");
  //LOG_STAT("SMT: { \"total_solving_time\": " + decstr(solving_time_) + " }\n");
  return res;
}

bool Solver::checkAndSave(const std::string& postfix) {
  if (check() == z3::sat) {
#if DEBUG_RUNTIME
    LOG_DEBUG("\nSolver Model z3::sat :: {" + solver_.to_smt2() + "\n}\n");
#endif
    saveValues(postfix);
    return true;
  }
  else {
    LOG_DEBUG("z3::unsat\n");
    return false;
  }
}

void Solver::addJcc(ExprRef e, bool taken, ADDRINT pc) {
#if DEBUG_RUNTIME
  std::cerr << "====================== Start negating path for the pushed constraint =============================\n";
  std::cerr << e->toString() << std::endl;
  std::cerr << "====================== Start negating path for the pushed constraint =============================\n\n\n";
#endif

  // Save the last instruction pointer for debugging
  last_pc_ = pc;

  if (e->isConcrete()) {
#if DEBUG_RUNTIME
  std::cerr << "[IGOGO] IT IS FULLY CONCRETIZED :: " << e->toString() << std::endl;
  e->symbolize();
  std::cerr << "[IGOGO] Let's do the trick and symbolize :: " << e->toString() << std::endl;
#endif
    //return;
  }

  // if e == Bool(true), then ignore
  if (e->kind() == Bool) {
    assert(!(castAs<BoolExpr>(e)->value()  ^ taken));
    return;
  }

  assert(isRelational(e.get()));

  // check duplication before really solving something,
  // some can be handled by range based constraint solving
  bool is_interesting;
  if (pc == 0) {
    // If addJcc() is called by special case, then rely on last_interested_
    is_interesting = last_interested_;
  }
  else
    is_interesting = isInterestingJcc(e, taken, pc);

  std::cerr << "[Solver::addJcc] isInteresting=" << (is_interesting ? "true\n": "false\n");

  if (is_interesting)
    negatePath(e, taken);
  
  // we already negated pushed constraint and saved results, so add this constraint into our forest...
  addConstraint(e, taken, is_interesting);
#if DEBUG_RUNTIME
  std::cerr << "[Solver::addJcc] DepForest after negating path and adding constraint to the solver:" << std::endl;
  dep_forest_.printForest(std::cerr);
  std::cerr << "====================== End negating path for the pushed constraint =============================\n";
  std::cerr << e->toString() << std::endl;
  std::cerr << "====================== End negating path for the pushed constraint =============================\n\n\n";
#endif
}

void Solver::addAddr(ExprRef e, ADDRINT addr) {
  llvm::APInt v(e->bits(), addr);
  addAddr(e, v);
}

void Solver::addAddr(ExprRef e, llvm::APInt addr) {
  if (e->isConcrete())
    return;

  if (last_interested_) {
    reset();
    // TODO: add optimize in z3
    syncConstraints(e);
    if (check() != z3::sat)
      return;
    z3::expr &z3_expr = e->toZ3Expr();

    // TODO: add unbound case
    z3::expr min_expr = getMinValue(z3_expr);
    z3::expr max_expr = getMaxValue(z3_expr);
    solveOne(z3_expr == min_expr);
    solveOne(z3_expr == max_expr);
  }

  addValue(e, addr);
}

void Solver::addValue(ExprRef e, ADDRINT val) {
  llvm::APInt v(e->bits(), val);
  addValue(e, v);
}

void Solver::addValue(ExprRef e, llvm::APInt val) {
  if (e->isConcrete())
    return;

#ifdef DEBUG_RUNTIME
  // trace_addValue(e, val);
  llvm::APInt calculated;
  ExprRef ce = e->evaluate();
  switch (ce->kind()) {
    // Cannot handle Bool case, but is handled by bitToBool
    case Constant:
      calculated = castAs<ConstantExpr>(ce)->value();
    default:
      UNREACHABLE();
      calculated = llvm::APInt(1, 1);
  }
  
  if (calculated != val) {
    LOG_FATAL("Mismatch!"
          "\nexpr=" + e->toString()
        + "\nreal=" + val.toString(16, false)
        + "\ncalculate=" + calculated.toString(16, false)
        + "\n");
  }
#endif

  ExprRef expr_val = g_expr_builder->createConstant(val, e->bits());
  ExprRef expr_concrete = g_expr_builder->createBinaryExpr(Equal, e, expr_val);

  addConstraint(expr_concrete, true, false);
}

void Solver::solveAll(ExprRef e, llvm::APInt val) {
  if (last_interested_) {
    std::string postfix = "";
    ExprRef expr_val = g_expr_builder->createConstant(val, e->bits());
    ExprRef expr_concrete = g_expr_builder->createBinaryExpr(Equal, e, expr_val);

    reset();
    syncConstraints(e);
    addToSolver(expr_concrete, false);

    if (check() != z3::sat) {
      // Optimistic solving
      reset();
      addToSolver(expr_concrete, false);
      postfix = "optimistic";
    }

    z3::expr z3_expr = e->toZ3Expr();
    while(true) {
      if (!checkAndSave(postfix))
        break;
      z3::expr value = getPossibleValue(z3_expr);
      add(value != z3_expr);
    }
  }
  addValue(e, val);
}

UINT8 Solver::getInput(ADDRINT index) {
  assert(index < inputs_.size());
  return inputs_[index];
}

void Solver::checkOutDir() {
  // skip if there is no out_dir
  if (out_dir_.empty()) {
    LOG_INFO("Since output directory is not set, use stdout\n");
    return;
  }

  struct stat info;
  if (stat(out_dir_.c_str(), &info) != 0
      || !(info.st_mode & S_IFDIR)) {
    LOG_FATAL("No such directory\n");
    exit(-1);
  }
}

void Solver::readInput() {
  std::ifstream ifs (input_file_, std::ifstream::in | std::ifstream::binary);
  if (ifs.fail()) {
    LOG_FATAL("Cannot open an input file\n");
    exit(-1);
  }

  char ch;
  while (ifs.get(ch))
    inputs_.push_back((UINT8)ch);
}

std::vector<UINT8> Solver::getConcreteValues() {
  // TODO: change from real input
  z3::model m = solver_.get_model();
  unsigned num_constants = m.num_consts();
  std::vector<UINT8> values = inputs_;
  for (unsigned i = 0; i < num_constants; i++) {
    z3::func_decl decl = m.get_const_decl(i);
    z3::expr e = m.get_const_interp(decl);
    z3::symbol name = decl.name();

    if (name.kind() == Z3_INT_SYMBOL) {
      int value = e.get_numeral_int();
      values[name.to_int()] = (UINT8)value;
    }
  }
  return values;
}

void Solver::saveValues(const std::string& postfix) {
  std::vector<UINT8> values = getConcreteValues();

  // If no output directory is specified, then just print it out
  if (out_dir_.empty()) {
    printValues(values);
    return;
  }

  std::string fname = out_dir_+ "/" + toString6digit(num_generated_);
  // Add postfix to record where it is genereated
  if (!postfix.empty())
      fname = fname + "-" + postfix;
  ofstream of(fname, std::ofstream::out | std::ofstream::binary);
  LOG_INFO("New testcase: " + fname + "\n");
  if (of.fail())
    LOG_FATAL("Unable to open a file to write results\n");

      // TODO: batch write
      for (unsigned i = 0; i < values.size(); i++) {
        char val = values[i];
        of.write(&val, sizeof(val));
      }

  of.close();
  num_generated_++;
}

// @Information(alekum): We wanna dump this forest to see all the trees and nodes(qsym::ExprRef)
// But more important we want to see how many dependandt trees we have in regard with input offset
void Solver::printDepForest(std::ostream& os) {
  dep_forest_.printForest(os);
}

void Solver::printValues(const std::vector<UINT8>& values) {
  fprintf(stderr, "[INFO] Values: ");
  for (unsigned i = 0; i < values.size(); i++) {
    fprintf(stderr, "\\x%02X", values[i]);
  }
  fprintf(stderr, "\n");
}

z3::expr Solver::getPossibleValue(z3::expr& z3_expr) {
  z3::model m = solver_.get_model();
  return m.eval(z3_expr);
}

z3::expr Solver::getMinValue(z3::expr& z3_expr) {
  push();
  z3::expr value(context_);
  while (true) {
    if (checkAndSave()) {
      value = getPossibleValue(z3_expr);
      solver_.add(z3::ult(z3_expr, value));
    }
    else
      break;
  }
  pop();
  return value;
}

z3::expr Solver::getMaxValue(z3::expr& z3_expr) {
  push();
  z3::expr value(context_);
  while (true) {
    if (checkAndSave()) {
      value = getPossibleValue(z3_expr);
      solver_.add(z3::ugt(z3_expr, value));
    }
    else
      break;
  }
  pop();
  return value;
}

void Solver::addToSolver(ExprRef e, bool taken) {
  // std::cerr << "[QSYM::Solver::addToSolver] Before simplify " << e.get() << " :: [ " << e->toString() << " ]\n";
  e->simplify();
  // std::cerr << "[QSYM::Solver::addToSolver] After simplify " << e.get() << " :: [ " << e->toString() << " ]\n";
  if (!taken)
    e = g_expr_builder->createLNot(e);
#if 0
  std::cerr << "\n\t[QSYM::Solver::addToSolver] Z3Expr :: [ " << e->toZ3Expr(false) << " ]\n";
#endif
  add(e->toZ3Expr());
}

/// Resolve Concrete Dependencies
/// @param ExpRef ref to expresion where deps should be investigated and turned into concrete if might
/// @param deps   pointer to dep set with symbolic only deps for this expression(basically, it is parents deps)
/// 
/// Our assumption is that we could turn dependecies into concrete ones if there is no symbolic deps 
/// between parent expression and dependant expression
void Solver::resolveConcreteDep(ExprRef e, DependencySet* symdeps) {
#if DEBUG_RUNTIME
  std::cerr << "[QSYM::Solver::resolveConcreteDep] resolve Expr=" << e 
            << ", depth="  << e->depth() << ", num_children=" << e->num_children()
            << " :: [ " << e->toString() << " ]\n";
  std::cerr << "[QSYM::Solver::resolveConcreteDep] for symbolic deps :: [ ";
  for(const size_t idx : *symdeps) std::cerr << idx << " "; 
  std::cerr << " ]\n";
#endif

  // It would be better to propagate dep_idx -> SymExpr(Leaf) to avoid this BFS
  // Here we might see perf penarly is we copy elements AGAIN and we could not construct them...
  std::deque<ExprRef> wq;
  wq.push_back(e);
  while(!wq.empty()) {
    ExprRef we = wq.front();
    wq.pop_front();
    
    if(we->isConcrete()) continue; // if it has happened to be concrete 

    // currently we care about the ReadExpr only as it looks like this node is a leaf
    if(auto re = castAs<ReadExpr>(we)) {
#if DEBUG_RUNTIME
      std::cerr << "Found requried dep=" << re->index() << " :: " << re
                << " :: [ " << re->toString() 
                << " ] to be concretized, isConcrete=" 
                << (re->isConcrete() ? "true" : "false") << "\n";
#endif
      if (!symdeps->count(re->index())) {
        ExprRef evaluated = re->evaluate();

        // Assume ReadExpr has only one usage(a.k.a parent) i.e SExt(Read)
        // @Cleanup(alekum) not a better impl though let's check, also, what will happen with
        // dangling shared_ptr...
        // FIXME might be better idea to evaluate SExt(ReadExpr) == ReadExpr and get Constant avoiding this parent issues
        // and not mess up with bitness
        ExprRef parent = re->uses()[0].lock();

        std::cerr << std::endl << parent->evaluate()->toString() << std::endl << std::endl;

#if DEBUG_RUNTIME
        std::cerr << "Get user parent :: " << parent << " " << parent->toString() << "\n";
#endif
        evaluated->setBitness(parent->bits()); // assuming ReadExpr(bits=8), Sext(bits=32|64)...
        //std::cerr << "Z3 Evaluated Expr : " << evaluated->toZ3Expr() << "\n";

        // As right now it should work iterating over all uses to swap corretctly with Concrete value
        // and we still assume that ReadExpr has only one uses...
        // otherwise we should iterate over users and gather candidates for swapping...resolve later
        // FIXME
        bool found = false;
        for(const auto &it : parent->uses()) {
          ExprRef pparent = it.lock(); // first better check it.expired()

          if(!pparent && pparent->isConcrete()) {
            std::cerr << "Get user skipped :: pointer is null or parent is completely concrete\n";
            continue;
          }
#if DEBUG_RUNTIME
          std::cerr << "Get user :: " << pparent << " " << pparent->toString() << "\n";
#endif
          // Based on API from expr.h looks like it doesn't matter how many children we have...
          // we have access to left(first) and right(second) children
          found = true;
          if(pparent->getChild(0) == parent) {
            pparent->SwapChild(evaluated, 0);
          } else if (pparent->getChild(1) == parent) {
            pparent->SwapChild(evaluated, 1);
          } else {
            found = false;
          }
          //std::cerr << "Canonical Constant :: "; 
          //std::cerr << pparent->uses()[0].lock()->getChild(0)->toZ3Expr() << std::endl;
          if(found) { 
            evaluated->addUse(pparent); // update list of evaluated expressions...
            re->concretize(); // now we sure that it should be concrete...
          } else {
            std::cerr << "\n\t[!!! We screwed up!!!!! I could not find a place to swap evaluted expr with sym one ]\n\n";
          }
        }

        // Assume we swap with evaluated value, so parent should clear its uses...
        parent->clearUses();

#if DEBUG_RUNTIME
        std::cerr << "Requried dep="
                << re->index() << ", isConcrete=true " << evaluated << " :: [ "
                << evaluated->toString() << " ]\n";
#endif

      }
    }
    // update wq adding children of e, anyway if it is leaf we don't have children, I hope...
    for(INT32 i = 0; i < we->num_children(); ++i) {
      wq.push_back(we->getChild(i));
    }
  }
#if DEBUG_RUNTIME
  std::cerr << "[QSYM::Solver::resolveConcreteDep] Resolved Expr " << e << " :: [ " << e->toString() << " ]\n";
#endif
}

void Solver::resolveNodeDep(ExprRef e, const DependencySet &concrete, const DependencySet &symbolic) {
  if(!e) return;
  if(e->kind() == Kind::Read) {
    auto RE = castAsNonNull<ReadExpr>(e);
    auto idx = RE->index(); // for ReadExpr dep_ is sym input index
    if(concrete.count(idx)) {
      RE->concretize();
    } else if (symbolic.count(idx)) {
      RE->symbolize();
    } else {
      std::cerr << "[Solver::resolveNodeDep] Could not decide what to do with idx = " << idx << std::endl;
    }
  }
  for(INT32 i = 0; i < e->num_children(); ++i) resolveNodeDep(e->getChild(i), concrete, symbolic);
}

void Solver::syncConstraints(ExprRef e) {
  std::set<std::shared_ptr<DependencyTree<Expr>>> forest;
  DependencySet* expr_sym_deps = &e->getDeps();// e->getDependencies();
#if DEBUG_RUNTIME
  std::cerr << "[QSYM::Solver] syncConstraints for ExpRef(qsym::Expr)=" 
            << e.get() << " [\n\t" << e->toString() << "\n] with Symbolic Dependencies = [ ";
  for(const auto d : *expr_sym_deps) std::cerr << d << ' ';
  std::cerr << " ]\n";
#endif
  for (const size_t& index : *expr_sym_deps) {
    auto tree = dep_forest_.find(index);
#if 0
    std::cerr << "[QSYM::Solver] Print Tree fpr idx=" << index << ":\n";\
    tree->printTree();
#endif
    forest.insert(tree);
  }

  std::cerr << std::endl;

  DependencySet sd, cd;
  for (std::shared_ptr<DependencyTree<Expr>> tree : forest) {
    std::vector<std::shared_ptr<Expr>> nodes = tree->getNodes();

    for(const auto d : tree->getDependencies()) {
      if(!expr_sym_deps->count(d)) {
        cd.insert(d);
      } else {
        sd.insert(d);
      }
    }

    std::cerr << "\n\nFOR TREE " << tree << " :: SYMDEP [ ";
    for(const auto d : sd) {
      std::cerr << d << ' ';
    }
    std::cerr << "], CONCRETE DEP [ ";
    for(const auto d : cd) {
      std::cerr << d << ' ';
    }
    std::cerr << "]\n\n";

    for (std::shared_ptr<Expr> node : nodes) {
#if DEBUG_RUNTIME
      std::cerr << "[QSYM::Solver] syncConstraints for ExpRef(qsym::Expr)=" 
                << node.get() << " [\n\t" << node->toString() << "\n] with Dependencies = [ ";
      for(const auto d : node->getDeps()) std::cerr << d << ' ';
      std::cerr << " ]\n";
#endif
      // Node fully concrete -> skip :: otherwise concretize CD Nodes, symbolize SD nodes
      bool isAllDepConcrete = std::all_of(node->getDeps().begin(), 
                                        node->getDeps().end(), 
                                        [&cd](const auto d){ return cd.count(d);});
      if(isAllDepConcrete) continue;

      if (isRelational(node.get())) {
// #if DEBUG_RUNTIME
//         std::cerr << "\t\trel node=[ " << node->toString() << " ]\n";
// #endif
//         resolveConcreteDep(node, deps);
//         if(!node->isConcrete())
          resolveNodeDep(node, cd, sd);
          addToSolver(node, true);
      } else {
        // Process range-based constraints
        bool valid = false;
        for (INT32 i = 0; i < 2; i++) {
          ExprRef expr_range = getRangeConstraint(node, i);
          if (expr_range != NULL) {
//             resolveConcreteDep(expr_range, deps);
// #if DEBUG_RUNTIME
//             std::cerr << "\t\texpr_range("<<expr_range<<")=[ " << expr_range->toString() 
//                       << "], isConcrete=" << (expr_range->isConcrete() ? "true" : "false") << "\n";
// #endif
//             if(!expr_range->isConcrete())
              resolveNodeDep(node, cd, sd);
              addToSolver(expr_range, true);
            valid = true;
          }
        }

        // One of range expressions should be non-NULL
        if (!valid)
          LOG_INFO(std::string(__func__) + ": Incorrect constraints are inserted\n");
      }
    }
  }
  //std::cerr << "[QSYM::Solver::syncConstraints] Dump synced Expression=" 
  //          << e.get() << " :: [ " << e->toString() << " ]\n";
  
  // @FIXME(alekum): will call check first time and solver will try to solve constraints...
  // before the place where it actually should be called
  // checkFeasible();
}

void Solver::addConstraint(ExprRef e, bool taken, bool is_interesting) {
  if (auto NE = castAs<LNotExpr>(e)) {
    addConstraint(NE->expr(), !taken, is_interesting);
    return;
  }
  if (!addRangeConstraint(e, taken))
    addNormalConstraint(e, taken);
}

void Solver::addConstraint(ExprRef e) {
  // If e is true, then just skip
  if (e->kind() == Bool) {
    QSYM_ASSERT(castAs<BoolExpr>(e)->value());
    return;
  }
  if (e->isConcrete())
    return;
#if DEBUG_RUNTIME
  std::cerr << "[QSYM::Solver] Add Constraint " << e << " :: [ " << e->toString() << " ] "
            << "into DepForest=" << &dep_forest_ << std::endl;
#endif
  dep_forest_.addNode(e);
}

bool Solver::addRangeConstraint(ExprRef e, bool taken) {
  if (!isConstSym(e))
    return false;

  Kind kind = Invalid;
  ExprRef expr_sym, expr_const;
  parseConstSym(e, kind, expr_sym, expr_const);
  ExprRef canonical = NULL;
  llvm::APInt adjustment;
  getCanonicalExpr(expr_sym, &canonical, &adjustment);
  llvm::APInt value = static_pointer_cast<ConstantExpr>(expr_const)->value();

  if (!taken)
    kind = negateKind(kind);

  canonical->addConstraint(kind, value,
      adjustment);
  addConstraint(canonical);
  //updated_exprs_.insert(canonical);
  return true;
}

void Solver::addNormalConstraint(ExprRef e, bool taken) {
  if (!taken)
    e = g_expr_builder->createLNot(e);
  addConstraint(e);
}

ExprRef Solver::getRangeConstraint(ExprRef e, bool is_unsigned) {
  Kind lower_kind = is_unsigned ? Uge : Sge;
  Kind upper_kind = is_unsigned ? Ule : Sle;
  RangeSet *rs = e->getRangeSet(is_unsigned);
  
  if (rs == NULL)
    return NULL;

#if 0
  if(rs->num_intervals() > 0) {
    std::cerr << "[QSYM::Solver] getRangeConstraint for ExprRef(qsym::Expr)=" << e << "\n\t";
    rs->print();
    std::cerr << '\n';
    // if it is not satisfied why in the hell we going further
  }
#endif

  ExprRef expr = NULL;
  for (auto i = rs->begin(), end = rs->end();
      i != end; i++) {
    const llvm::APSInt& from = i->From();
    const llvm::APSInt& to = i->To();
    ExprRef bound = NULL;

    if (from == to) {
      // can simplify this case
      ExprRef imm = g_expr_builder->createConstant(from, e->bits());
      bound = g_expr_builder->createEqual(e, imm);
    }
    else
    {
      ExprRef lb_imm = g_expr_builder->createConstant(i->From(), e->bits());
      ExprRef ub_imm = g_expr_builder->createConstant(i->To(), e->bits());
      ExprRef lb = g_expr_builder->createBinaryExpr(lower_kind, e, lb_imm);
      ExprRef ub = g_expr_builder->createBinaryExpr(upper_kind, e, ub_imm);
      bound = g_expr_builder->createLAnd(lb, ub);
    }

    if (expr == NULL)
      expr = bound;
    else
      expr = g_expr_builder->createLOr(expr, bound);
  }

  return expr;
}


bool Solver::isInterestingJcc(ExprRef rel_expr, bool taken, ADDRINT pc) {
  bool interesting = trace_.isInterestingBranch(pc, taken);
  // record for other decision
  last_interested_ = interesting;
  return interesting;
}

void Solver::negatePath(ExprRef e, bool taken) {
  reset();
  syncConstraints(e);
  addToSolver(e, !taken);
  
#if 0
  // @Information(alekum): this place looks good to filter our Expr and turn few Sym into conrete
  std::cerr << "[QSYM::Solver::negatePath] Dump Dep Forest for this Solver:\n";
  this->printDepForest();
#endif
  
  bool sat = checkAndSave();
  if (!sat) {
    reset();
    // optimistic solving
    addToSolver(e, !taken);
    checkAndSave("optimistic");
  }
}

void Solver::solveOne(z3::expr z3_expr) {
  push();
  add(z3_expr);
  checkAndSave();
  pop();
}

void Solver::checkFeasible() {
#ifdef DEBUG_RUNTIME
  if (check() == z3::unsat)
    LOG_FATAL("Infeasible constraints: " + solver_.to_smt2() + "\n");
#endif
}

} // namespace qsym
