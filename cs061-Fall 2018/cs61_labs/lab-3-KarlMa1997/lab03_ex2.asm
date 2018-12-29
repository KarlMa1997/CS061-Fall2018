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

  LDI R3, Dec_65_ptr
  LDI R4, Hex_41_ptr
  
  ADD R3, R3, #1
  ADD R4, R4, #1
  
  STI R3, Dec_65_ptr
  STI R4, Hex_41_ptr
  
  HALT
  
;local data
Dec_65_ptr .FILL x4000
Hex_41_ptr .FILL x4001

.orig x4000
Dec_65 .FILL #65
Hex_41 .FILL x41

.END