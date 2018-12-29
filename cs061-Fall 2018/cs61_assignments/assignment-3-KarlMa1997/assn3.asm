;=================================================
; Name: Kaihang Ma	
; Email: kma023@ucr.edu
; GitHub username:KarlMa1997
; 
; Assignment name: Assignment 3
; Lab section: 028
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_addr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HEthe purRE
;--------------------------------
AND R5,R5,#0
AND R4,R4,#0
ADD R5,R5,#15
ADD R4,R4,#4

LOOP
  ADD R4,R4,#0
  BRp NEXT
    LEA R0,space
    PUTS
    AND R4,R4,#0
    ADD R4,R4,#4
    ADD R5,R5,#0
     
  BR END_NEXT
    NEXT
    ADD R1,R1,#0

  BRn LOOP2
    LEA R0,strzero
    PUTS
    
  BR END_LOOP2
    LOOP2
    LEA R0,strone
    PUTS
  END_LOOP2
  
    ADD R1,R1,R1
    ADD R4,R4,#-1
    ADD R5,R5,#-1
    END_NEXT

BRzp LOOP

LEA R0,NEWLINE
PUTS



HALT
;---------------	
;Data
;---------------
Value_addr	.FILL xDA00	; The address where value to be displayed is stored

strone .STRINGZ "1"
strzero .STRINGZ "0"
space .STRINGZ " "
NEWLINE .STRINGZ "\n"
.ORIG xDA00					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
