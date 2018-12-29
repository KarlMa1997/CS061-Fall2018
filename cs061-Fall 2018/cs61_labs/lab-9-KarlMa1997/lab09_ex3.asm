;=================================================
; Name: KAIHANG MA	
; Email: kma023@ucr.edu 
; GitHub username: KarlMa1997
; 
; Lab: lab 8
; Lab section: 028
; TA: Jason
;=================================================
.ORIG x3000
LD R4,ptrBASE
LD R5,ptrMAX
LD R6,ptrBASE
  
PUSH_LOOP
  ;LEA R0,PUSHPROM
  ;PUTS
  AND  R0,R0,#0
  GETC
  OUT

  LD R2,DEC_0
  ADD R0,R0,R2

  LD R1,SUB_STACK_PUSH
  JSRR  R1
  ADD R3,R3,#0
  BRnz PUSH_LOOP
  BRp CALL_SUB_MUL
  
CALL_SUB_MUL
  LD R1,SUB_RPN_MULTIPLY
  JSRR R1


  
  HALT
  
HEX_30		 .FILL x0030
DEC_0 	  	 .FILL #-48
;PUSHPROM  	 .STRINGZ "PUSH VALUE\n"
;POPPROM  	 .STRINGZ "POP VALUE\n "
SUB_STACK_PUSH   .FILL x3500
ptrBASE  	 .FILL x4000
ptrMAX   	 .FILL x4002
SUB_STACK_POP    .FILL x5000
SUB_RPN_MULTIPLY .FILL x5500

HALT
;-------------------------------------------------------
;subroutine:SUB_STACK_PUSH
;parameter(R0): The value to push onto the stack
;parameter(R3); push overflowing flag (positive means overflowing)
;parameter(R4): BASE: A pointer to the base (one less than the lowest aviliable
;		      address) of the stack
;parameter(R5): MAX: The highest available address in the stack
;parameter(R6): TOS: A pointer to the current top of the stack
;postcondition: The subroutine has pushed R0 onto the stack (i.e. to address TOS+1)
;		If the stack was already full (TOS = MAX), the subroutine has 
;		printed an overflow error message and terminated.
;return value(R6): R6  <-- updated TOS
;--------------------------------------------------------
.ORIG x3500

ST R1,BACKUP_R1_x3500
ST R2,BACKUP_R2_x3500
ST R7,BACKUP_R7_x3500

AND R3,R3,#0
AND R1,R1,#0

ADD R1,R1,R6   ;R1 IS SUB VALUE OF R6
NOT R1,R1
ADD R1,R1,#1
ADD R1,R1,R5

IF
  BRz TRUE
  FALSE
    ADD R6,R6,#1
    STR R0,R6,#0
    ;LEA R0,NEWLINE
    ;PUTS
    BR END_IF
  TRUE
    ADD R3,R3,#1
    ;LEA R0,PUSHOVERFLOW
    ;PUTS
  END_IF
 
LD R1,BACKUP_R1_x3500
LD R2,BACKUP_R2_x3500
LD R7,BACKUP_R7_x3500

RET

BACKUP_R1_x3500 .BLKW #1
BACKUP_R2_x3500 .BLKW #1
BACKUP_R7_x3500 .BLKW #1
NEWLINE   .STRINGZ "\n"
;PUSHOVERFLOW .STRINGZ "\nStack is overflowing.\n"

;-------------------------------------------------------
;subroutine:SUB_STACK_POP
;parameter(R3); push overflowing flag (positive means overflowing)
;parameter(R4): BASE: A pointer to the base (one less than the lowest aviliable
;		      address) of the stack
;parameter(R5): MAX: The highest available address in the stack
;parameter(R6): TOS: A pointer to the current top of the stack
;postcondition: The subroutine has popped MEM[tos] off of the stack.
;		If the stack was already empty (TOS==BASE), the subroutine has printed
;		an underflow error message off the stack
;return value(R6):R0 <-- value popped off the stack
;		  R6  <-- updated TOS
;--------------------------------------------------------
.ORIG x5000
;ST R0,BACKUP_R0_x5000
ST R1,BACKUP_R1_x5000
ST R2,BACKUP_R2_x5000
;ST R3,BACKUP_R3_x3500
;ST R4,BACKUP_R4_x4000
;ST R5,BACKUP_R5_x4000
;ST R6,BACKUP_R6_x4000
ST R7,BACKUP_R7_x5000

AND R3,R3,#0
AND R1,R1,#0
AND R0,R0,#0

ADD R1,R1,R6   ;R1 IS SUB VALUE OF R6
NOT R1,R1
ADD R1,R1,#1
ADD R1,R1,R4

IF1
  BRz TRUE1
  FALSE1
    LDR R0,R6,#0
    ADD R6,R6,#-1
    BR END_IF1
  TRUE1
    ADD R3,R3,#1
    ;LEA R0,POPUNDERFLOW
    ;PUTS
  END_IF1
 
;LD R0,BACKUP_R0_x5000
LD R1,BACKUP_R1_x5000
LD R2,BACKUP_R2_x5000
;LD R3,BACKUP_R3_x3500
;LD R4,BACKUP_R4_x4000
;LD R5,BACKUP_R5_x4000
;LD R6,BACKUP_R6_x4000
LD R7,BACKUP_R7_x5000

RET

;BACKUP_R0_x5000 .BLKW #1
BACKUP_R1_x5000 .BLKW #1
BACKUP_R2_x5000 .BLKW #1
;BACKUP_R3_x3500 .BLKW #1
;BACKUP_R4_x4000 .BLKW #1
;BACKUP_R5_x4000 .BLKW #1
;BACKUP_R6_x4000 .BLKW #1
BACKUP_R7_x5000 .BLKW #1
;POPUNDERFLOW .STRINGZ "\nStack is underflowing.\n"

;-------------------------------------------------------
;subroutine:SUB_RPN_MULTIPLY
;parameter(R4): BASE: A pointer to the base (one less than the lowest aviliable
;		      address) of the stack
;parameter(R5): MAX: The highest available address in the stack
;parameter(R6): TOS: A pointer to the current top of the stack
;postcondition: The subroutine has popped off the top two values of the stack,
;		multiplied them together, and pushed the resulting value back
;		onto the stack
;return value(R6): R6  <-- updated TOS address
;--------------------------------------------------------
.ORIG x5500
ST R0,BACKUP_R0_x5500
ST R1,BACKUP_R1_x5500
ST R2,BACKUP_R2_x5500
ST R3,BACKUP_R3_x5500
;ST R4,BACKUP_R4_x4000
;ST R5,BACKUP_R5_x4000
;ST R6,BACKUP_R6_x4000
ST R7,BACKUP_R7_x5500

AND R2,R2,#0
AND R3,R3,#0
LD R1,SUB_STACK_POP1
JSRR R1
ADD R2,R2,R0
LD R1,SUB_STACK_POP1
JSRR R1
ADD R3,R3,R0

;---MULTI R2 AND R3
;---R1 IS COUNTER
AND R1,R1,#0
MULT
  ADD R1,R1,R2
  ADD R3,R3,#-1
  BRp MULT

;---PUSH BACK RESULT TO STACK
AND R0,R0,#0
ADD R0,R0,R1
LD R2,SUB_PRINT_NUMBER
JSRR R2
LD R2,SUB_STACK_PUSH1
JSRR R2


  
LD R0,BACKUP_R0_x5500
LD R1,BACKUP_R1_x5500
LD R2,BACKUP_R2_x5500
LD R3,BACKUP_R3_x5500
;LD R4,BACKUP_R4_x4000
;LD R5,BACKUP_R5_x4000
;LD R6,BACKUP_R6_x4000
LD R7,BACKUP_R7_x5500

RET

BACKUP_R0_x5500 .BLKW #1
BACKUP_R1_x5500 .BLKW #1
BACKUP_R2_x5500 .BLKW #1
BACKUP_R3_x5500 .BLKW #1
;BACKUP_R4_x4000 .BLKW #1
;BACKUP_R5_x4000 .BLKW #1
;BACKUP_R6_x4000 .BLKW #1
BACKUP_R7_x5500 .BLKW #1
SUB_STACK_PUSH1   .FILL x3500
SUB_STACK_POP1    .FILL x5000
SUB_PRINT_NUMBER .FILL x5850
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_NUMBER
; Inputs: R1 the value from input number subroutine
; Postcondition: 
; The subroutine prints the number that is in R1
; Return Value : 
; NOTE: This subroutine should print the number to the user WITHOUT 
;		leading 0's and DOES NOT output the '+' for positive numbers.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.ORIG x5850		
ST R0,BACKUP_R0_x5850
;ST R1,BACKUP_R1_x5850
ST R2,BACKUP_R2_x5850
ST R3,BACKUP_R3_x5850
ST R4,BACKUP_R4_x5850
ST R5,BACKUP_R5_x5850
ST R6,BACKUP_R6_x5850
ST R7,BACKUP_R7_x5850
  
  ADD R1,R1,#1
  
  LOOPD_10_TEMP
    AND R4,R4,#0
    LD R3,NNEG10
    AND R6,R6,#0
    ADD R6,R6,R1
    ADD R6,R6,R3
      BRn PRINTZERO_10D
      BRz PRINT10D
      BRp LOOP_10D
      
  LOOP_10D
    LD R3,NNEG10
    ADD R4,R4,#1
    ADD R1,R1,R3
    ADD R6,R6,R3
      BRp LOOP_10D
      BR PRINT10D
  
  PRINT10D
    AND R0,R0,#0
    ADD R5,R5,#1
    ADD R0,R0,R4
    LD R3,HEX_30A
    ADD R0,R0,R3
    OUT
    
  LOOP_1_TEMPD
    AND R4,R4,#0
    LD R3,NNEG1
    AND R6,R6,#0
    ADD R6,R6,R1
    ADD R6,R6,R3
      BRn PRINTZERO_1D
      BRz PRINT1D
      BRp LOOP_1D
      
  LOOP_1D
    LD R3,NNEG1
    ADD R4,R4,#1
    ADD R2,R2,R3
    ADD R6,R6,R3
      BRp LOOP_1D
      BR PRINT1D
  
  PRINT1D
    AND R0,R0,#0
    ADD R5,R5,#1
    ADD R0,R0,R4
    LD R3,HEX_30A
    ADD R0,R0,R3
    OUT
    BR HALT0
    
  PRINTZERO_10D
    AND R0,R0,#0
    ADD R5,R5,#0
    BRz #7
    ADD R4,R4,#0
    BRz #0
    ADD R0,R0,#0
    BRz #3
    LD R3,HEX_30A
    ADD R0,R0,R3
    OUT
    BR LOOP_1_TEMPD
    
   PRINTZERO_1D
    AND R0,R0,#0
    ADD R5,R5,#0
    BRz #5
    ADD R4,R4,#0
    BRz #0
    LD R3,HEX_30A
    ADD R0,R0,R3
    OUT
    BR HALT0
    
   HALT0
    BR #0
   
;=====================================================
LD R0,BACKUP_R0_x5850
;LD R1,BACKUP_R1_x5850
LD R2,BACKUP_R2_x5850
LD R3,BACKUP_R3_x5850
LD R4,BACKUP_R4_x5850
LD R5,BACKUP_R5_x5850
LD R6,BACKUP_R6_x5850
LD R7,BACKUP_R7_x5850

RET

BACKUP_R0_x5850 .BLKW #1
;BACKUP_R1_x5850 .BLKW #1
BACKUP_R2_x5850 .BLKW #1
BACKUP_R3_x5850 .BLKW #1
BACKUP_R4_x5850 .BLKW #1
BACKUP_R5_x5850 .BLKW #1
BACKUP_R6_x5850 .BLKW #1
BACKUP_R7_x5850 .BLKW #1

NNEG10 .FILL #-10
NNEG1 .FILL #-1
HEX30 .FILL x30
HEX_30A .FILL x0030
NEWLINE4 .STRINGZ "\n"