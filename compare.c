#include <stdio.h>
#include <string.h>
#include <stdbool.h>

int main (int argc, char **argv) 
{

	FILE *fd1 = fopen(argv[1], "r");
	FILE *fd2 = fopen(argv[2], "r");

	bool cond = true;
	char line1[1000], line2[1000];
	int lines = 1;

	while (fgets(line1, 1000, fd1) != NULL && fgets(line2, 1000, fd2) != NULL) {

		if ( strcmp(line1, line2) != 0 ) {

			cond = false;

			printf("#%d: ", lines);
			printf("%s\t%s\n", line1, line2);

		}

		lines++;

	}

	if (cond == true) {

		printf("OK\n");

	}


	fclose(fd1);
	fclose(fd2);

	return 0;
}
