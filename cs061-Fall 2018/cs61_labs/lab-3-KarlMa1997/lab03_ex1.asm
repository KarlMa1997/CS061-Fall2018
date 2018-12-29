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

  LD R3, Dec_65
  LD R4, Hex_41
  
  HALT
  
;local data

Dec_65 .FILL #65
Hex_41 .FILL x41

.END