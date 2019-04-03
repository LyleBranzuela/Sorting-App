.ORIG x3000 

LEA R0, StudentDetails
PUTS

LEA R0, Question
PUTS 

AND R0, R0, #0	
AND R2, R2, #0

LEA R3, UserInput ;Specifies the Address of the UserInput variable to the Register (R3)

LOOP
	GETC
	ADD R1, R0, #-10
	BRz OUTSIDE
	
	STR R0, R3, #0
	ADD R5, R5, #1 ;Total count including zero in the loop, will be used for bubble sort
	ADD R3, R3, #1 ;Make to storing pointer of R3 (User Input), to point to next location
	OUT

	SPACECHECKER
		LD R4, SpaceChar ; Resets Register 4 Every Loop for Checking each time
		ADD R4, R0, R4 ;Checks if it's space or not
		BRz LOOP ;Goes back to the loop and doesn't add 1 to the counter
		ADD R2, R2, #1 ;If it's false then add 1 to the counter
	BRnzp LOOP
OUTSIDE

	LEA R0, EnteredAnswer ; Print  "You have entered: "
	PUTS	

	LEA R0, UserInput ; Prints out the User Input
	PUTS

	LEA R0, NumberOfChar ; Print  "There are "
	PUTS

	LD R0, CharacterZero ; Amount of Characters
		ADD R0, R0, R2
	OUT

	LEA R0, InTheList ; Print " numbers in the list"
	PUTS
	
	AND R1, R1, #0 ;Set R1 to Zero so that I can reuse it to the other loop as a number placeholder
	AND R2, R2, #0 ;Set R2 to Zero so that I can reuse it to the other loop as a number placeholder
	AND R3, R3, #0 ;Reset R3 File Pointer
	AND R4, R4, #0 ;Reset R4, to save the counter for the max number

	ADD R4, R5, #-1 ;Store the total number of all numbers for the max number, -1 to remove the Enter Character
	
	OUTERLOOP	
			ADD R5, R5, #-1 ;Total Count (Including Zero) - 1, So that it checks for every number
			BRnz OUTSIDEHERE ;Get out if the total count is already zero
			ADD R6, R5, #0 ;Save the total count to create a counter for the inner loop
			LEA R3, UserInput
	INNERLOOP	
			LDR R2, R3, #0  ;Save the current number to R2, so that I can reuse it in printing the Smallest number
			LDR R1, R3, #2  ;Save the next number to R1
			NOT R7, R1	;Convert second number in the array into negative, through 2's complementary
			ADD R7, R7, #1	;Save the conversion
			ADD R7, R2, R7	;Current Number - Negated Second Number
			BRnz NUMBERSSWAPPED
			STR R1, R3, #0	;Store the next number to the current number's position in the array
			STR R2, R3, #2  ;Store the current number to the next number's position in the array
	NUMBERSSWAPPED	
			ADD R3, R3, #2  ;Move the pointer down by 2
			ADD R6, R6, #-2 ;Decrement the outer loop's counter by 2
			BRp INNERLOOP
			BRnzp OUTERLOOP 
	OUTSIDEHERE

	LEA R0, SmallestNumberText ; Print "The smallest number is: "
	PUTS

	AND R3, R3, #0 ;Reset The Register to Zero
	LEA R3, UserInput ; Print out the smallest number
		LDR R0, R3, #0 ;Load The character/number by the pointer, which is the first number/character
	OUT

	LEA R0, LargestNumberText ; Print "The largest number is: "
	PUTS
		
	AND R3, R3, #0 ;Reset the Register to 0
	LEA R3, UserInput ; Print out the largest number
		ADD R3, R3, R4 ;Add the max number to the pointer so that the pointer goes to the last character/number
		LDR R0, R3, #0 ;Load the character/number specified by the pointer, which is the last character/number
	OUT

	LEA R0, SortList ;Print "The sorted list is: "
	PUTS
	
	LEA R0, UserInput ;The Sorted List
	PUTS

HALT

UserInput	.BLKW 20
CharacterZero	.fill x30
SpaceChar	.fill #-32

StudentDetails	.stringz "Lyle Branzuela, ID Number: 17982811\n"	
Question	.stringz "Please enter a list of numbers from 1-9 separated by spaces: "
EnteredAnswer	.stringz "\nYou have entered: "
NumberOfChar	.stringz "\nThere are "
InTheList	.stringz " numbers in the list\n"
SmallestNumberText	.stringz "The smallest number is: "
LargestNumberText 	.stringz "\nThe largest number is: "
SortList	.stringz "\nThe sorted list is: "

.end








