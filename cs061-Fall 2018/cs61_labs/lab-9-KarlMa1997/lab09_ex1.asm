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
  
LOOP
  LEA R0,PUSHPROM
  PUTS
  AND  R0,R0,#0
  GETC
  OUT

  LD R2,DEC_0
  ADD R0,R0,R2

  LD R1,SUB_STACK_PUSH
  JSRR  R1
  BR LOOP
  
  HALT
  
  
DEC_0 	  .FILL #-48
PUSHPROM  .STRINGZ "PUSH VALUE\n"
SUB_STACK_PUSH .FILL x3500
ptrBASE  .FILL x4000
ptrMAX   .FILL x4005


HALT
;-------------------------------------------------------
;subroutine:SUB_STACK_PUSH
;parameter(R0): The value to push onto the stack
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
ST R3,BACKUP_R3_x3500
;ST R4,BACKUP_R4_x4000
;ST R5,BACKUP_R5_x4000
;ST R6,BACKUP_R6_x4000
ST R7,BACKUP_R7_x3500

AND R1,R1,#0
ADD R1,R1,R6   ;R1 IS SUB VALUE OF R6
NOT R1,R1
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
    LEA R0,PUSHOVERFLOW
    PUTS
  END_IF
 
;LD R0,BACKUP_R0_x4000
LD R1,BACKUP_R1_x3500
LD R2,BACKUP_R2_x3500
LD R3,BACKUP_R3_x3500
;LD R4,BACKUP_R4_x4000
;LD R5,BACKUP_R5_x4000
;LD R6,BACKUP_R6_x4000
LD R7,BACKUP_R7_x3500

RET

;BACKUP_R0_x4000 .BLKW #1
BACKUP_R1_x3500 .BLKW #1
BACKUP_R2_x3500 .BLKW #1
BACKUP_R3_x3500 .BLKW #1
;BACKUP_R4_x4000 .BLKW #1
;BACKUP_R5_x4000 .BLKW #1
;BACKUP_R6_x4000 .BLKW #1
BACKUP_R7_x3500 .BLKW #1
NEWLINE   .STRINGZ "\n"
PUSHOVERFLOW .STRINGZ "\nStack is overflowing.\n"