/*
  Author: Gary Yap Hon Shin 
  Created: 6/7/2016 (d-m-y)
  
  This is a "Hello World" program to test
  whether the basic requirement of the 
  MCU is set up properly.If everything is
  working properly, two LED at PORT0,pin2
  and pin3 will be toggle alternatively 
  at the rate of 0.5 second for each interval.
*/
	
	LED8 DATA P0;
	
	ORG 0000H;
	
MAIN:	MOV A,#0FBH;
	MOV LED8,A;
	CALL DELAY;
	RL	A;
	MOV LED8,A;
	CALL DELAY;
	SJMP MAIN;
		
DELAY:	MOV R2,#5;
DLY1:	MOV R1,#200
DLY0:	MOV R0,#250
	DJNZ R0,$
	DJNZ R1,DLY0
	DJNZ R2,DLY1
	RET
	END	
		
		
	
