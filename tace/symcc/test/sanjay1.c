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
	//if(fsize<40 || fsize>1999)
	//	return -1;
	fread(str, sizeof(char), fsize, (FILE*)fp);
	//char str[]="AAAAA*a(xxxxxxx9aa)e+rrrrrrr55566677\n";
	/*	
	for(i=0;i<1;++i)//(fsize-6);i++)
	{
		if((str[i]+str[i+1])<(str[i+3]+str[i+4]+str[i+5]))
			check++;
	}
	*/

	// Suppose compiler unroll few iterations of this loop...
	// final attempt is to try 19 iterations, just to touch offset 24
	if((str[i]+str[i+1])<(str[i+3]+str[i+4]+str[i+5]))
		check++;
	i++;
	if((str[i]+str[i+1])<(str[i+3]+str[i+4]+str[i+5]))
		check++;
	i++;
	if((str[i]+str[i+1])<(str[i+3]+str[i+4]+str[i+5]))
		check++;

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
