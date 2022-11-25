#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  // char str1[]="aaaaaaa(xxxxxxx9aa)e+rrrrrrr55566677\n";
  char str1[0xFF];
  FILE *fd;
  fd = fopen(argv[1], "rb");
  int ret = fread(str1, sizeof(char), sizeof(str1), fd);
  fclose(fd);

  // on symcc level as I though on kirenenko level we could combine such branches into big one
  // iff the body of the branch is just nested branch withouth any instructions....which means
  // we just fallthrough all the conditions to the most nested one....
  if (str1[15] + str1[7] == 'a') {
    // some code
    printf("branch 1\n");
    if (str1[15] + str1[18] == 'b') {
      printf("branch 2\n");
      if (str1[18] + str1[20] == 'h') {
        printf("vulnerable branch 3\n");
        // vulnerable_function(&str1[30]);
        abort();
      } else
        printf("branch 5\n");
    } else
      printf("branch 6\n");
  }

  printf("branch 0\n");
  return 0;
}
  
