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
  LEA R0,PUSHPROM
  PUTS
  AND  R0,R0,#0
  GETC
  OUT

  LD R2,DEC_0
  ADD R0,R0,R2

  LD R1,SUB_STACK_PUSH
  JSRR  R1
  ADD R3,R3,#0
  BRnz PUSH_LOOP
  BRp POP_LOOP

POP_LOOP
  LEA R0,POPPROM
  PUTS
  
  LD R1,SUB_STACK_POP
  JSRR R1
  ADD R3,R3,#0
  BRnz POP_LOOP
  BRp END_POP
  
  END_POP
  
  
  
  
  HALT
  
  
DEC_0 	  .FILL #-48
PUSHPROM  .STRINGZ "PUSH VALUE\n"
POPPROM  .STRINGZ "POP VALUE\n "
SUB_STACK_PUSH .FILL x3500
ptrBASE  .FILL x4000
ptrMAX   .FILL x4005
SUB_STACK_POP  .FILL x5000



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
;ST R0,BACKUP_R0_x3500
ST R1,BACKUP_R1_x3500
ST R2,BACKUP_R2_x3500
;ST R3,BACKUP_R3_x3500
;ST R4,BACKUP_R4_x4000
;ST R5,BACKUP_R5_x4000
;ST R6,BACKUP_R6_x4000
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
    LEA R0,NEWLINE
    PUTS
    BR END_IF
  TRUE
    ADD R3,R3,#1
    LEA R0,PUSHOVERFLOW
    PUTS
  END_IF
 
;LD R0,BACKUP_R0_x4000
LD R1,BACKUP_R1_x3500
LD R2,BACKUP_R2_x3500
;LD R3,BACKUP_R3_x3500
;LD R4,BACKUP_R4_x4000
;LD R5,BACKUP_R5_x4000
;LD R6,BACKUP_R6_x4000
LD R7,BACKUP_R7_x3500

RET

;BACKUP_R0_x4000 .BLKW #1
BACKUP_R1_x3500 .BLKW #1
BACKUP_R2_x3500 .BLKW #1
;BACKUP_R3_x3500 .BLKW #1
;BACKUP_R4_x4000 .BLKW #1
;BACKUP_R5_x4000 .BLKW #1
;BACKUP_R6_x4000 .BLKW #1
BACKUP_R7_x3500 .BLKW #1
NEWLINE   .STRINGZ "\n"
PUSHOVERFLOW .STRINGZ "\nStack is overflowing.\n"

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
    LD R2,HEX_30
    ADD R0,R0,R2
    OUT
    ADD R6,R6,#-1
    LEA R0,NEWLINE2
    PUTS
    BR END_IF1
  TRUE1
    ADD R3,R3,#1
    LEA R0,POPUNDERFLOW
    PUTS
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
NEWLINE2   .STRINGZ "\n"
HEX_30     .FILL x0030
POPUNDERFLOW .STRINGZ "\nStack is underflowing.\n"