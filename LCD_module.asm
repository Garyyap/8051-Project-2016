/*
	Author : Gary Yap Hon Shin
	Created: 7/7/2016 (d-m-y)
	
	The following is LCD module code.
	This code uses the LCD 4bit mode feature,
	as this will dramatically reduce number of 
	physcial wire required. PORT 2 (7-4)is the data bus,
	where port 1.0 = EN and port 1.1 = RS
*/

	  RS equ P1.1; //RS = 1 DATA , RS = 0 COMMAND
	  EN equ P1.0;
	  Upper_nibble equ 35H;
	  Lower_nibble equ 36H;

	  ORG 0000H
	  ACALL LCD_DELAY;
	  ACALL LCD_INIT;
	  MOV 37H,#30H;
	  ACALL WRITE_DATA;
	
MAIN: 	  MOV A,37H;
	  ADD A,#01H;
	  MOV 37H,A;
	  ACALL WRITE_DATA;
	  ACALL Heart_beat;
	  ACALL CLEAR_LCD;
	  SJMP MAIN;
	  
	  
LCD_INIT: MOV P2,#20H;
	  CLR RS;
	  SETB EN;
	  ACALL LCD_DELAY;
	  CLR EN;
		
	  MOV A, #28H
	  ACALL WRITE_COMMAND;
	  MOV A, #0CH
	  ACALL WRITE_COMMAND;
	  MOV A, #06H
	  ACALL WRITE_COMMAND;
	  MOV A, #01H
	  ACALL WRITE_COMMAND;
	  RET;

	
Heart_beat: SETB P0.0;
	    ACALL DELAY;
	    clr  P0.0;
	    ACALL DELAY;
	    RET;
			 
CLEAR_LCD:  MOV A,#01H;
	    ACALL WRITE_COMMAND;
	    RET;
			 
WRITE_COMMAND: CLR RS;
	       ACALL BIT4_FORMAT;
	       MOV P2, Upper_nibble;
	       SETB EN;
	       ACALL LCD_DELAY;
	       CLR EN;
	       MOV P2, Lower_nibble;
	       SETB EN;
	       ACALL LCD_DELAY;
	       CLR EN;
	       RET;
			   
WRITE_DATA:    SETB RS;
	       ACALL BIT4_FORMAT;
	       MOV P2, Upper_nibble;
	       SETB EN;
	       ACALL LCD_DELAY;
	       CLR EN;
	       MOV P2, Lower_nibble;
	       SETB EN;
	       ACALL LCD_DELAY;
	       CLR EN;
	       RET;
			  
			  
//Use to separate 8bit data into 4bit chuncks.
BIT4_FORMAT: MOV Upper_nibble,A;
             ANL Upper_nibble,#0F0H;
	     SWAP A;
	     ANL A,#0F0H;
	     MOV Lower_nibble,A;
	     RET;

//1s delay	
DELAY:	MOV R2,#10; //1s
DLY1 :	MOV R1,#200;//0.1s
DLY0 :	MOV R0,#250;
	DJNZ R0,$;//500uS
	DJNZ R1,DLY0; 
	DJNZ R2,DLY1;
	RET;
	
//12.75mS delay
LCD_DELAY: MOV  20H,#50;          
DELAY2   : MOV  21H,#255;          
DELAY3   : DJNZ 21H,DELAY3;
           DJNZ 20H,DELAY2;
           RET;
		
	   END
	
