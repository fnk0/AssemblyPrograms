// CS 3443
// Marcus Gabilheri

#include <stdio.h>

int main() {

	printf("FizzBuzz by Marcus Gabilheri\n");

	int numTimes;
	printf("Please input an integer: ");
	scanf("%d", &numTimes);

	for(int i = 1; i <= numTimes; i++) {

		if(i % 3 == 0 && i % 5 == 0) {
			printf("Marcus Gabilheri\n");
		} else if(i % 3 == 0) {
			printf("Marcus\n");
		} else if(i % 5 == 0) {
			printf("Gabilheri\n");
		} else {
			printf("%d\n", i);
		}
	}
	
	return 0;
}