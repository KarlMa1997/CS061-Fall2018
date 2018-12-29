;=================================================
; Name: Kaihang Ma
; Email:  kma023@ucr.edu	
; GitHub username: KarlMa1997
; 
; Lab: lab 5
; Lab section: 028
; TA: Jason
; 5
;=================================================

.orig x3000
LD R1, ptr
LD R2, size
LD R4, HEX_30
LD R0, START_VALUE


LOOP
  STR R0,R1,#0
  ADD R0,R0,R0
  ADD R1,R1,#1
  ADD R2,R2,#-1
  BRp LOOP
END_LOOP



LEA R0,NEWLINE
PUTS

LD R1, ptr
LD R2, size

LOOP2
  LDR R0,R1,#0
  ADD R0,R0,R4
  OUT
  ADD R1,R1,#1
  ADD R2,R2,#-1
  BRp LOOP2
END_LOOP2 


HALT

START_VALUE .FILL #1
DEC_0	.FILL #0
HEX_30	.FILL x30
ptr .FILL x4000
size .FILL #10
NEWLINE .STRINGZ "\n"

.orig x4000
.BLKW #10