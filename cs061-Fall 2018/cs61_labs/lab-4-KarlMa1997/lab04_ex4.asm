;=================================================
; Name: Kaihang Ma	
; Email:  kma023@ucr.edu
; GitHub username: KarlMa1997
; 
; Lab: lab 4
; Lab section: 028
; TA: Jason
; 
;=================================================

.orig x3000
LD R1, ptr

LOOP
  GETC
  ADD R2,R0,#-10
  BRz END_LOOP
  
  OUT
  STR R0,R1,#0
  ADD R1,R1,#1
  BRnzp LOOP
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

HALT

ptr .FILL x4000
NULL .FILL #0
NEWLINE .STRINGZ "\n"
.orig x4000
.BLKW #100