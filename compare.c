#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#define MAX_LENGTH 1000

int main (int argc, char **argv) 
{
	
	FILE *fd1 = fopen(argv[1], "r");
	FILE *fd2 = fopen(argv[2], "r");

	bool mismatch = false;
	char line1[MAX_LENGTH], line2[MAX_LENGTH];
	int lines = 1;

	while (fgets(line1, MAX_LENGTH, fd1) != NULL && fgets(line2, MAX_LENGTH, fd2) != NULL) {
		if ( strcmp(line1, line2) != 0 ) {

			mismatch = true;

			printf("#%d: ", lines);
			printf("%s\t%s\n", line1, line2);
		}

		lines++;
	}

	if (!mismatch) {
		printf("OK\n");
	}


	fclose(fd1);
	fclose(fd2);

	return 0;
	
}
