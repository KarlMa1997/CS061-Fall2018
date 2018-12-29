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
LD R3,ptr

LDR R3,R5,#0
LDR R4,R5,#1

HALT

ptr .FILL x4000

.orig x4000
Dec_65 .FILL #65
Hex_41 .FILL x41