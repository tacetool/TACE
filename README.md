# TACE

This is a binary-only symbolic/concolic executor based on QEMU, SymCC, and TACE. 

## How to build

To understand the build steps, please check (Dockefile)[Dockefile]. It is considered a self-documented step.
The build happens through several stages of building foundations where TACE patches 
are applied to required components.

To build a test case, it is enough to do the following:

> Please install docker depending on the system you use.

```
docker build -t tace -f Dockefile .
docker run -it --rm tace /bin/bash
```

> This will build the required docker container and environment, which is ready to go for development.
>
> All necessary patches are applied. Updating the Dockerfile to use other source repos is possible.

## How to run a basic example

A basic example program that represents an approach where bloating of symbolic deps happens due to deps between branches.

```cpp 
//symbex2.c
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    char *file = argv[1];
    char str[2000];//tainted buffer
    int fsize;
    int check=0, i;
    FILE *fp = fopen(file, "r");
    fseek(fp, 0, SEEK_END); // seek to end of file
    fsize = ftell(fp); // get current file pointer
    fseek(fp, 0, SEEK_SET); // seek back to beginning of file
	if(fsize<40 || fsize>1999)
		return -1;
    fread(str, sizeof(char), fsize, (FILE*)fp);
    for(i=0;i<(fsize-6);i++)
    {
      if((str[i]+str[i+1])<(str[i+3]+str[i+4]+str[i+5]))
	check++;
    }
	// push constraint from loop
	if(check<1)
	{
		printf("too many large chars. Exiting!\n");
		return -1;
	}
    if(str[7] + str[5] == 'R')
    {
        printf("branch 1\n");
        if(str[18] + str[19] == 'b')
        {
            //some code
            printf("branch 2\n");
            if(str[2] + str[4] == 'X')
                {
                    printf("unrelated branch 1\n");
                }
            if(str[4] + str[8] == 'X')
                {
                    printf("unrelated branch 2\n");
                }
            if(str[15] + str[18] == 'U')
            {
                printf("branch 3\n");
                if(str[5] + str[9] == 'X')
                {
                    printf("unrelated branch 3\n");
                }
                if(str[11] + str[24] == 'X')
                {
                    printf("unrelated branch 4\n");
                }
                if(str[15] + str[14] == 'g')
                {
                    printf("vulnerable branch 4\n");
                    //vulnerable_function(&str[30]);
                    abort();
                }
                else
                    printf("branch 5\n");
             }
            else
              printf("branch 6\n");
        }
    }
    printf("branch 0\n");
 	return 0;
 }

```

Once docker is run, WORKDIR is setup for `/tmp` folder.
You might find there the source above, created folder for the cases and garbage.
By default backend handles STDIN input, but to specify a file that should be treated as symbolic, use  `SYMCC_INPUT_FILE` variable. If you want to change output folder location, use `SYMCC_OUTPUT_DIR` variable. Check below

To run simple case(workdir=/tmp):

```
cc -O2 sanjay1_loop.c -o test.elf
echo 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' > input
SYMCC_INPUT_FILE=/tmp/input SYMCC_OUTPUT_FOLDER=/tmp/output taceqemu /tmp/test.elf /tmp/input
```

Example of output:

```
FOR TREE 0x55e94ea2a040 :: SYMDEP [ ], CONCRETE DEP [ ]

[STAT] SMT: {"solving_time_elapsed": 1242 }
[INFO] New testcase: /tmp/output/000000
[Solver::addJcc] isInteresting=true



FOR TREE 0x55e94ea01650 :: SYMDEP [ 1 4 5 ], CONCRETE DEP [ 0 3 ]



FOR TREE 0x55e94ea2a040 :: SYMDEP [ 1 4 5 ], CONCRETE DEP [ 0 3 ]



FOR TREE 0x55e94eb63420 :: SYMDEP [ 1 4 5 ], CONCRETE DEP [ 0 3 ]

[STAT] SMT: {"solving_time_elapsed": 1429 }
[INFO] New testcase: /tmp/output/000001
[Solver::addJcc] isInteresting=true



FOR TREE 0x55e94ea01650 :: SYMDEP [ 2 3 5 6 ], CONCRETE DEP [ 0 1 4 ]



FOR TREE 0x55e94eb29150 :: SYMDEP [ 2 3 5 6 ], CONCRETE DEP [ 0 1 4 ]

[STAT] SMT: {"solving_time_elapsed": 1686 }
[INFO] New testcase: /tmp/output/000002
[Solver::addJcc] isInteresting=true



FOR TREE 0x55e94ea01650 :: SYMDEP [ 3 4 6 7 ], CONCRETE DEP [ 0 1 2 5 ]



FOR TREE 0x55e94eb26290 :: SYMDEP [ 3 4 6 7 ], CONCRETE DEP [ 0 1 2 5 ]

[STAT] SMT: {"solving_time_elapsed": 1905 }
[INFO] New testcase: /tmp/output/000003
[Solver::addJcc] isInteresting=false

```

Printed log demonstrates state of the current tree, location of the test case, solving time, and considered dependencies

## License

Extends the QEMU,SYMCC,SYMQEMU,SQYM , and our contributions to previously existing
files adopt those files' respective licenses; the files that we have added are
made available under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or (at your
option) any later version.
