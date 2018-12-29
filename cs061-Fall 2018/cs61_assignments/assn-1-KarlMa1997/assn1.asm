;=================================================
; Name: Kaihang Ma
; Email: kma023@ucr.edu
; GitHub username: KarlMa1997
; 
; Assignment name: Assignment 1
; Lab section: 028
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

;----------------------------------------------------
;REG VALUES         R0           R1          R2        R3        R4        R5        R6         R7
;----------------------------------------------------
;Pre-loop	  x0000 0   x7FFF 32767   x0000 0    x0000 0   x0000 0   x0000 0   x0000 0  x0490 1168 
;Iteration 01     x0000 0   x0006 6       x000C 12   x0000 0   x0000 0   x0000 0   x0000 0  x0490 1168
;Iteration 02     x0000 0   x0005 5       x000C 12   x000C 12  x0000 0   x0000 0   x0000 0  x0490 1168
;Iteration 03     x0000 0   x0004 4       x000C 12   x0018 24  x0000 0   x0000 0   x0000 0  x0490 1168
;Iteration 04     x0000 0   x0003 3       x000C 12   x0024 36  x0000 0   x0000 0   x0000 0  x0490 1168
;Iteration 05     x0000 0   x0002 2       x000C 12   x0030 48  x0000 0   x0000 0   x0000 0  x0490 1168
;Iteration 06     x0000 0   x0001 1       x000C 12   x003C 60  x0000 0   x0000 0   x0000 0  x0490 1168
;Iteration 07     x0000 0   x0000 0       x000C 12   x0048 72  x0000 0   x0000 0   x0000 0  x3007 DEC_0
;End of program
;-----------------------------------------------------
.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;-------------------------------
LD R1, DEC_6			;R1 <-- 6
LD R2, DEC_12			;R2 <-- 12
LD R3, DEC_0			;R3 <-- 0

DO_WHILE	ADD R3, R3, R2  ;R3 <-- R3 + R2
		ADD R1, R1, #-1 ;R1 <-- R1 - 1
		BRp DO_WHILE	;if (LMR > 0)goto DO_WHILE
;--------------------------------

HALT				;Terminate the program
;---------------	
;Data
;---------------
DEC_0	.FILL	#0		;Put the value 0 into memory here
DEC_6	.FILL	#6		;Put the value 6 into memory here
DEC_12	.FILL	#12		;Put the value 12 into memory here

;---------------	
;END of PROGRAM
;---------------	
.END
