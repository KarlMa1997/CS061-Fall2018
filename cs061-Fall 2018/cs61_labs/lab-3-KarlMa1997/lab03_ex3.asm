;=================================================
; Name: Kaihang Ma	
; Email: kma023@ucr.edu
; GitHub username: KarlMa1997
; 
; Lab: lab 3
; Lab section: 028
; TA: Jason
; 
;=================================================
.orig x3000

  LD R1, ptr
  
  LDR R3, R1, #0
  LDR R4, R1, #1
  
  ADD R3, R3, #1
  ADD R4, R4, #1
  
  STR R3, R1, #0
  STR R4, R1, #1
  
  HALT
  
;local data
ptr .FILL x4000

.orig x4000
Dec_65 .FILL #65
Hex_41 .FILL x41

.END