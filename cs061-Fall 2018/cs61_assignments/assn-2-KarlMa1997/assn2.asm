

;=================================================
; Name: Kaihang Ma	
; Email: kma023@ucr.edu	
; GitHub username:KarlMa1997
; 
; Assignment name: Assignment 2
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

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE BELOW
;--------------------------------
GETC
OUT
AND R1,R1,#0
ADD R1,R1,R0
LEA R0,NEWLINE
PUTS

GETC
OUT
AND R2,R2,#0
ADD R2,R2,R0
LEA R0,NEWLINE
PUTS

AND R3,R3,#0
AND R4,R4,#0
AND R5,R5,#0
ADD R3,R3,#15
ADD R3,R3,#15
ADD R4,R3,#2
ADD R3,R3,#15
ADD R3,R3,#3
ADD R5,R5,R3
NOT R3,R3
ADD R3,R3,#1

ADD R1,R1,R3
ADD R2,R2,R3
AND R6,R6,#0
ADD R0,R1,R6
ADD R0,R0,R5
OUT

AND R6,R6,#0
ADD R0,R4,R6
OUT

ADD R3,R4,#13
AND R6,R6,#0
ADD R0,R3,R6
OUT

AND R6,R6,#0
ADD R0,R4,R6
OUT

AND R6,R6,#0
ADD R0,R2,R6
ADD R0,R0,R5
OUT

AND R6,R6,#0
ADD R0,R4,R6
OUT

ADD R3,R3,#15
ADD R3,R3,#1
AND R6,R6,#0
ADD R0,R3,R6
OUT

AND R6,R6,#0
ADD R0,R4,R6
OUT

NOT R2,R2
ADD R2,R2,#1
ADD R6,R1,R2

BRn negative
BR positive

    negative 	NOT R6,R6
		ADD R6,R6,#1
		AND R3,R3,#0
		ADD R3,R4,#13
		AND R4,R4,#0
		ADD R0,R3,R4
		OUT
    
    positive 	ADD R6,R6,R5
		AND R4,R4,#0
		ADD R0,R6,R4
		OUT

LEA R0,NEWLINE
PUTS

HALT				; Stop execution of program
;------	
;Data
;------
; String to explain what to input 
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with PUTS. Note: already includes terminating newline!
NEWLINE .FILL '\n'	; newline character - use with OUT



;---------------	
;END of PROGRAM
;---------------	
.END

