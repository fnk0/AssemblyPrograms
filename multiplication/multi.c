#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef int bool;
#define true 1
#define false 0

int main() {

	printf("Multiplication by Marcus Gabilheri\n");
	printf("Please input first integer: ");
	int num1;
	int num2;
	int result = 0;
	scanf("%d", &num1);
	printf("Please input second integer: ");
	scanf("%d", &num2);
	
	while(num2 > 0) {
		result +=  num1;
		num2--;
	}

	printf("Result = %d\n", result);

	return 0;

}