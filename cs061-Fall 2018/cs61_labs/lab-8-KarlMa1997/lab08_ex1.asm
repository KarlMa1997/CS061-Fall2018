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

LD R3,SUB_GET_STRING
JSRR R3

SUB_GET_STRING .FILL x3500

HALT
;-------------------------------------------------------
;subroutine:SUB_GET_STRING
;parameter(r1): the string address of the character array
;postcondition: the subroutine has prompted the user to input a string, 
;		terminated by the [enter] key, 
;		and has stored it in an array of characters starting at r1;
;		the array is null-terminated
;return value(r5): the  number of non-sentinel characters read from the user
;		R1 still contains the starting address of array
;--------------------------------------------------------
.ORIG x3500
ST R0,BACKUP_R0_x3500
;ST R1,BACKUP_R1_x3500
ST R2,BACKUP_R2_x3500
ST R3,BACKUP_R3_x3500
ST R4,BACKUP_R4_x3500
;ST R5,BACKUP_R5_x3500
ST R6,BACKUP_R6_x3500
ST R7,BACKUP_R7_x3500

LD R1,ptr

LEA R0,PROM
PUTS

LOOP
  GETC
  ADD R2,R0,#-10
  BRz END_LOOP
 
  OUT
  STR R0,R1,#0
  ADD R1,R1,#1
  ADD R5,R5,#1
  
  BRnzp LOOP
  END_LOOP

LD R2,NULL
STR R2,R1,#0
 
LD R0,BACKUP_R0_x3500
;LD R1,BACKUP_R1_x3500
LD R2,BACKUP_R2_x3500
LD R3,BACKUP_R3_x3500
LD R4,BACKUP_R4_x3500
;LD R5,BACKUP_R5_x3500
LD R6,BACKUP_R6_x3500
LD R7,BACKUP_R7_x3500

RET

BACKUP_R0_x3500 .BLKW #1
;BACKUP_R1_x3500 .BLKW #1
BACKUP_R2_x3500 .BLKW #1
BACKUP_R3_x3500 .BLKW #1
BACKUP_R4_x3500 .BLKW #1
;BACKUP_R5_x3500 .BLKW #1
BACKUP_R6_x3500 .BLKW #1
BACKUP_R7_x3500 .BLKW #1
 
NULL .FILL #0
ptr .FILL x4000
PROM .STRINGZ "INPUT A STRING, ENDING WITH [ENTER]"
OCCUP .BLKW #100