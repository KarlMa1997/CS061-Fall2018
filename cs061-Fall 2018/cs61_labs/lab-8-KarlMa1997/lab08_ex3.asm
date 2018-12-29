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
LD R1,ptr

LEA R0,PROM
PUTS

LOOP
  GETC
  ADD R2,R0,#-10
  BRz END_LOOP
 
  OUT
  LD R4,UPCHECK
  AND R6,R6,#0
  ADD R6,R6,R0
  ADD R6,R6,R4
  BRnz #9
  AND R6,R6,#0
  ADD R6,R6,R0
  LD R4,LOCHECK
  ADD R6,R6,R4
  BRnz TOUPPER
  BR CONT
  
TOUPPER
  LD R7,DEC32
  ADD R0,R0,R7
  BR CONT
  
CONT
  STR R0,R1,#0
  ADD R1,R1,#1
 
  ADD R5,R5,#1
  BR LOOP
END_LOOP

LD R2,NULL
STR R2,R1,#0

LD R1,ptr

LEA R0,NEWLINE
PUTS

LOOP2
  LDR R0,R1,#0
  ADD R2,R0,#-0
  BRz END_LOOP2
  OUT
  ADD R1,R1,#1
  BRnzp LOOP2
END_LOOP2

LD R3,SUB_IS_A_PALINDROME
JSRR R3

ADD R4,R4,#-1
BRz PRINT1



HALT

ptr .FILL x4000
DEC32 .FILL #-32
UPCHECK .FILL #-90
LOCHECK .FILL #-122
NULL .FILL #0
NEWLINE .STRINGZ "\n"
PROM .STRINGZ "INPUT A STRING, ENDING WITH [ENTER]"
SUB_IS_A_PALINDROME .FILL x5000
.orig x4000
.BLKW #100

;-------------------------------------------------------
;subroutine:SUB_IS_A_PALINDROME
;parameter(r1): the string address of the character array
;parameter(r5): 
;postcondition:  
;		
;		
;		
;return value(r4): 
;--------------------------------------------------------
.ORIG x5000
ST R0,BACKUP_R0_x5000
;ST R1,BACKUP_R1_x5000
ST R2,BACKUP_R2_x5000
ST R3,BACKUP_R3_x5000
;ST R4,BACKUP_R4_x5000
;ST R5,BACKUP_R5_x5000
ST R6,BACKUP_R6_x5000
ST R7,BACKUP_R7_x5000

AND R7,R7,#0
ADD R7,R7,#-1

ADD R2,R2,R5
NOT R2,R2
ADD R2,R2,#1
ADD R1,R1,R2

LOOP1

AND R4,R4,#0
ADD R4,R4,#-1

  AND R0,R0,#0
  ADD R7,R7,#1  ;R7 AS COUNTER
  ADD R4,R4,R7
  NOT R4,R4
  ADD R4,R4,#1
  ADD R4,R4,R5
  BRnz DONE
  
  
  ADD R0,R1,R7
  LDR R0,R0,#0
  
  ADD R3,R5,#-1
  ADD R5,R5,#-1
  ADD R6,R1,R3
  LDR R6,R6,#0
  
  NOT R6,R6
  ADD R6,R6,#1
  ADD R0,R0,R6
  
  
  BRz LOOP1
  BRnp FINISH

FINISH
  AND R4,R4,#0
  ADD R4,R4,#0
  BR #3
  
  
DONE
  AND R4,R4,#0
  ADD R4,R4,#1


  

 
LD R0,BACKUP_R0_x5000
;LD R1,BACKUP_R1_x5000
LD R2,BACKUP_R2_x5000
LD R3,BACKUP_R3_x5000
;LD R4,BACKUP_R4_x5000
;LD R5,BACKUP_R5_x5000
LD R6,BACKUP_R6_x5000
LD R7,BACKUP_R7_x5000

RET

BACKUP_R0_x5000 .BLKW #1
;BACKUP_R1_x5000 .BLKW #1
BACKUP_R2_x5000 .BLKW #1
BACKUP_R3_x5000 .BLKW #1
;BACKUP_R4_x5000 .BLKW #1
;BACKUP_R5_x5000 .BLKW #1
BACKUP_R6_x5000 .BLKW #1
BACKUP_R7_x5000 .BLKW #1
 