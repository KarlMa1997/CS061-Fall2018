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
LD R2, size

LOOP
  GETC
  OUT 
  STR R0,R1,#0
  ADD R1,R1,#1
  ADD R2,R2,#-1
  BRp LOOP
END_LOOP

LEA R0,NEWLINE
PUTS

LD R1,ptr
LD R2,size

LOOP2
  LDR R0,R1,#0
  OUT
  ADD R1,R1,#1
  ADD R2,R2,#-1
  BRp LOOP2
END_LOOP2


HALT

ptr .FILL x4000
size .FILL #10
NEWLINE .STRINGZ "\n"

.orig x4000
.BLKW #10