#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef int bool;
#define true 1
#define false 0

/*

int strampArray(char *a, char *b) {
	int i = 0;
	while(true) {
		int diff = *a - *b;
		if( diff != 0) return diff;
		if( *a == 0 || *b == 0 ) return diff;
		a++; // increment the pointers ==> $a = $s1 |=> lb $t2, 0($1)
		b++;
	}
}

*/

int main() {

	char strSearchable[32];
	char strSub[32];

	printf("String Search by Marcus Gabilheri\n");
	printf("Please input a String to be searchable: ");
	scanf("%s", strSearchable);
	printf("Please input a Sub String to search: "); 
	scanf("%s",strSub);

	//printf("%s\n", strSearchable);
	//printf("%s\n", strSub);
	
	int len = strlen(strSearchable);
	int subLen = strlen(strSub);
	bool found;

	int i = 0;
	while(i < len) {
		int j = 0;
		found = true;
		while(j < subLen) {
			if(strSearchable[i + j] != strSub[j]) {
				found = false;
				break;
			}
			j++;
		}
		if(found) {
			printf("%d\n", i);
		}
		i++;
	}
	
	return 0;
}