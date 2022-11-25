#ifndef QSYM_DEPENDENCY_H_
#define QSYM_DEPENDENCY_H_

#include <iostream>
#include <memory>
#include <set>
#include <vector>

namespace qsym {

  // typedef std::set<size_t> DependencySet;
  using DependencySet = std::set<size_t>;

  // // @Cleanup(alekum): Right now this class looks like not being used
  // // the only thing : it is for inheritance
  // class DependencyNode {
  //   public:
  //     DependencyNode();
  //     virtual ~DependencyNode();
  //     DependencySet* getDependencies();
  //     virtual DependencySet computeDependencies() = 0;
  //     void printDependencies(std::ostream& os=std::cerr) const {
  //       os << "[DepNode] " << this << ", deps_ = [ "; 
  //       for(const size_t idx : *dependencies_) {
  //         os << idx << ' ';
  //       }
  //       os << "]\n";
  //     }
  //     friend std::ostream& operator<<(std::ostream &os, const DependencyNode &DN) {
  //       DN.printDependencies(os);
  //     }
  //   private:
  //     DependencySet* dependencies_;
  // };

  template<class T>
  class DependencyTree {
    public:
      void addNode(std::shared_ptr<T> node) {
        DependencySet *deps = &node->getDeps(); // node->getDependencies();
        nodes_.push_back(node);
        deps_.insert(deps->begin(), deps->end());
#if DEBUG_RUNTIME
        this->printTree();
#endif
      }

      void merge(const DependencyTree<T>& other) {
        const DependencySet& other_deps = other.getDependencies();
        const std::vector<std::shared_ptr<T>>& other_nodes = other.getNodes();

        nodes_.insert(nodes_.end(), other_nodes.begin(), other_nodes.end());
        deps_.insert(other_deps.begin(), other_deps.end());
      }

      const DependencySet & getDependencies() const {
        return deps_;
      }

      const std::vector<std::shared_ptr<T>>& getNodes() const {
        return nodes_;
      }

      void printTree(std::ostream& os=std::cerr) {
        os << "[DepTree] This=" << this << ", [ \n";
        os << "\tnodes = [\n";
        for(const auto& node : nodes_) {
          os << "\t\t" << node->toString() << " :: [ ";
          for(const auto dep : node->getDeps()) os << dep << ' ';
          os << " ],\n";
        }
        os << "\t]\n";
        os << "\tset = [ ";
        for(const auto idx : deps_) {
          os << idx << ' '; 
        }
        os << "]\n]\n";
      }

    private:
      std::vector<std::shared_ptr<T>> nodes_;
      DependencySet deps_;
  };

  template<class T>
  class DependencyForest {
    public:
      std::shared_ptr<DependencyTree<T>> find(size_t index) {
#if DEBUG_RUNTIME
        std::cerr << "[DepForest] Trying to find or create DepTree for index=" << index << '\n'; 
#endif
        // @Cleanup(alekum) Optimize allocation here, allocate once == size of sym input 
        // or use map to use only necessary indicies
        if (forest_.size() <= index)
          forest_.resize(index + 1);

        if (forest_[index] == NULL)
          forest_[index] = std::make_shared<DependencyTree<T>>();

        assert(forest_[index] != NULL);
        return forest_[index];
      }

      void addNode(std::shared_ptr<T> node) {
        DependencySet* deps = &node->getDeps(); //node->getDependencies();
        std::shared_ptr<DependencyTree<T>> tree = NULL;
        for (const size_t index : *deps) {
          std::shared_ptr<DependencyTree<T>> other_tree = find(index);
          if (tree == NULL)
            tree = other_tree;
          else if (tree != other_tree) {
            tree->merge(*other_tree);
            // Update existing reference
            for (const size_t index : other_tree->getDependencies()) {
              forest_[index] = tree;
            }
          }
          forest_[index] = tree;
        }
        tree->addNode(node);
      }

      // @Cleanup(alekum): Find a better name  for this methid `dump` ???
      void printForest(std::ostream& os=std::cerr) {
        std::set<std::shared_ptr<DependencyTree<T>>> unique_trees;
        DependencySet forest_deps;
        os << "================== [DepForest] This=" 
            << this << ",size=" << forest_.size() << " : [\n"; 
        size_t idx = 0;
        for(const auto& DT : forest_) {
          os << "ForestTreeIdx=" << idx++ << ' ';
          if(DT) {
            unique_trees.insert(DT);
            forest_deps.insert(idx-1);
            DT->printTree(os);
          } else {
            os << "DT=0\n";
          }
        }
        os << "]\n";
        os << "====================== FOREST STATISTICS =========================\n";
        os << " Unique Trees        : " << unique_trees.size() << '\n';
        os << " Allocated Trees     : " << forest_.size() << '\n';
        os << " Sparse Idx          : " << (float)unique_trees.size() / forest_.size() << '\n';
        os << " Forest Dependencies : " << forest_deps.size() << " [ ";
        for(const auto d : forest_deps) os << d << ' ';
        os << "]\n";
        os << "==================================================================\n";
      }

    private:
      std::vector<std::shared_ptr<DependencyTree<T>>> forest_;
  };

} // namespace qsym

#endif
