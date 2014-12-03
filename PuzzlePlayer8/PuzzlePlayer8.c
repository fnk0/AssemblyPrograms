#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef int bool;
#define true 1
#define false 0

bool isValidResult(char* gameString) {

	int count = 0;
	char rightStr[10] = "12345678.";

	while(count < 9) {
		//printf("Count: %d, Char: %c \n", rightStr[count], *gameString);
		if(rightStr[count] != *gameString) {
			//printf("False!\n");
			return false;
		}
		gameString++;
		count++;
	}
	return true;
}

void printBoard(char* gameString) {

	int counter = 1;
	while(*gameString != '\0') {
		printf("%c", *gameString);
		if(counter % 3 == 0) {
			printf("\n");
		}
		counter++;
		gameString++;
	}
}

//12378.456
//-3 -1 1 3
// 123
// 45.
// 786
void swapChars(char* gameString, char toSwap) {

	int dotIndex;
	int swapIndex;
	int counter;
	//printf("To swap!! %c\n", toSwap);
	while(counter < 9) {
		//printf("%c\n", gameString[counter]);
		if(gameString[counter] == toSwap) {
			//printf("Swap: %d\n", toSwap);
			swapIndex = counter;
		}

		if(gameString[counter] == '.') {
			dotIndex = counter;
		}
		counter++;
	}

	int diff = swapIndex - dotIndex;
	//printf("Dot index: %d\n", dotIndex);
	//printf("Swap index: %d\n", swapIndex);
	//printf("diff: %d\n", diff);
	//printf("Dot index + 3: %c\n", gameString[dotIndex+3]);

	if(((diff == 1 || diff == -1) && (swapIndex / 3 == dotIndex / 3)) || diff == -3 || diff == 3) {
		gameString[dotIndex] = toSwap;
		gameString[swapIndex] = '.';
	} else {
		printf("Wrong move!\n");
	}
}

int main() {

	char strBoard[32];
	printf("Puzzle Player 8 by Marcus Gabilheri\n");
	printf("Please input a the initial board configuration: ");
	scanf("%s", strBoard);	
	char input[1];

	while(true) {
		printBoard(strBoard);
		printf("Please enter a valid integer: ");

		scanf("%s", input);

		swapChars(strBoard, *input);
		if(isValidResult(strBoard)) {
			printBoard(strBoard);
			printf("You Win!!!\n");
			return false;
		}
	}

	return 0;
}