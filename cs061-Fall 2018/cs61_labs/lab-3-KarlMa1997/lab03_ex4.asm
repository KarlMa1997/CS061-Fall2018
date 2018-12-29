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

  LD R0, Hex_61
  LD R1, Hex_1A
  
  LOOP
    OUT
    ADD R0, R0, #1
    ADD R1, R1, #-1
    BRp LOOP
    
  HALT
  
;local data
Hex_61 .FILL x61
Hex_1A .FILL x1A

.END