;=================================================
; Name: Kaihang Ma
; Email: kma023@ucr.edu
; GitHub username: KarlMa1997
; 
; Assignment name: Assignment 5
; Lab section: 028
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================
.ORIG x3000		; Program begins here
;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
WHILE_LOOP
  AND R6,R6,#0
  LD R4,MENU
  JSRR R4
  
  ADD R6,R6,#0
  BRp WHILE_LOOP
  
  AND R3,R3,#0
  ADD R3,R3,R1
  ADD R3,R3,#-1 ;ALL MACHINE BUSY
  BRz CALL1
  
  ADD R3,R3,#-1 ;ALL MACHINE FREE
  BRz CALL2
  
  ADD R3,R3,#-1 ;NUM BUSY MACHINE
  BRz CALL3
  
  ADD R3,R3,#-1 ;NUM FREE MACHINE
  BRz CALL4
  
  ADD R3,R3,#-1 ;MACHINE STATUS
  BRz CALL5
  
  ADD R3,R3,#-1 ;FIRST FREE
  BRz CALL6
  
  ADD R3,R3,#-1
  BRz HALTPROGRAM
  
HALTPROGRAM
  LEA R0,Goodbye
  PUTS
  HALT
  
CALL1
  LD R4,ALL_MACHINES_BUSY
  JSRR R4
  
  ADD R2,R2,#0
  ADD R2,R2,#-16
  BRz OUT_ALL_BUSY
  BRnp OUT_NOT_ALL_BUSY

  OUT_ALL_BUSY
    LEA R0,ALLBUSY
    PUTS
    BR WHILE_LOOP
    
  OUT_NOT_ALL_BUSY
    LEA R0,ALLNOTBUSY
    PUTS
    BR WHILE_LOOP
  
CALL2
  LD R4,ALL_MACHINES_FREE
  JSRR R4
  
  ADD R2,R2,#0
  ADD R2,R2,#-16
  BRn OUT_NOT_ALL_FREE
  BRz OUT_ALL_FREE
  
  OUT_ALL_FREE
    LEA R0,FREE
    PUTS
    BR WHILE_LOOP
    
  OUT_NOT_ALL_FREE
    LEA R0,NOTFREE
    PUTS
    BR WHILE_LOOP

CALL3
  LD R4,NUM_BUSY_MACHINES
  JSRR R4
  
  LEA R0,BUSYMACHINE1
  PUTS
  
  AND R1,R1,#0
  ADD R1,R1,R2
  LD R4,PRINT_NUMBER
  JSRR R4
  
  LEA R0,BUSYMACHINE2
  PUTS
  
   BR WHILE_LOOP
  
CALL4
   LD R4,NUM_FREE_MACHINES
   JSRR R4
    
   LEA R0,FREEMACHINE1
   PUTS
   
   AND R1,R1,#0
   ADD R1,R1,R2
   LD R4,PRINT_NUMBER
   JSRR R4
   
   LEA R0,FREEMACHINE2
   PUTS
    
   BR WHILE_LOOP
  
CALL5
  LD R4,MACHINE_STATUS
  JSRR R4
  
  LEA R0,STATUS1
  PUTS
  
  LD R4,PRINT_NUMBER
  JSRR R4
  
  ADD R2,R2,#-1
  BRz FREEPR
  BRn BUSYPR
  
  BUSYPR
    LEA R0,STATUS2
    PUTS
    BR WHILE_LOOP
  
  FREEPR
    LEA R0,STATUS3
    PUTS
    BR WHILE_LOOP
  
CALL6
  LD R4,FIRST_FREE
  JSRR R4
  
  AND R4,R4,#0
  ADD R4,R4,R6
  ADD R4,R4,#-8
  ADD R4,R4,#-8
  BRzp FIRT2
  
  ADD R6,R6,#0
  BRz FIRT2
  BR #2
  
 FIRT2
  LEA R0,FIRSTFREE2
  PUTS
  BR WHILE_LOOP
  
  LEA R0,FIRSTFREE1
  PUTS
  AND R1,R1,#0
  ADD R1,R1,R6
  LD R4,PRINT_NUMBER
  JSRR R4  
  LEA R0,NEWLINE5
  PUTS
  
  BR WHILE_LOOP

HALT
;---------------	
;Data
;---------------
;Add address for subroutines
MENU .FILL x3900
ALL_MACHINES_BUSY .FILL x4000
ALL_MACHINES_FREE .FILL x4500
NUM_BUSY_MACHINES .FILL x4800
NUM_FREE_MACHINES .FILL x5100
MACHINE_STATUS .FILL x5300
PRINT_NUMBER .FILL x5850
FIRST_FREE .FILL x5600

;Other data 
ASCIITODEC .FILL x0030
NEWLINE5	.STRINGZ "\n"
;Strings for options
Goodbye         .STRINGZ "Goodbye!\n"
ALLNOTBUSY      .STRINGZ "Not all machines are busy\n"
ALLBUSY         .STRINGZ "All machines are busy\n"
FREE            .STRINGZ "All machines are free\n"
NOTFREE		.STRINGZ "Not all machines are free\n"
BUSYMACHINE1    .STRINGZ "There are "
BUSYMACHINE2    .STRINGZ " busy machines\n"
FREEMACHINE1    .STRINGZ "There are "
FREEMACHINE2    .STRINGZ " free machines\n"
STATUS1         .STRINGZ "Machine "
STATUS2         .STRINGZ " is busy\n"
STATUS3         .STRINGZ " is free\n"
FIRSTFREE1      .STRINGZ "The first available machine is number "
FIRSTFREE2      .STRINGZ "No machines are free\n"
;NEWLINE         .FILL '\n'

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed the
;                          user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
.ORIG x3900

;ST R0,BACKUP_R0_x3900
;ST R1,BACKUP_R1_x3900
ST R2,BACKUP_R2_x3900
ST R3,BACKUP_R3_x3900
ST R4,BACKUP_R4_x3900
ST R5,BACKUP_R5_x3900
;ST R6,BACKUP_R6_x3900     WHILE LOOP 
ST R7,BACKUP_R7_x3900

LD R0,Menu_string_addr
PUTS

;GET INPUT AND ECHO
AND R0,R0,#0
GETC
OUT
AND R1,R1,#0
ADD R1,R1,R0
LEA R0,NEWLINE1
PUTS

;CONVERT ASCII TO DEC

LD R4,DEC_0
ADD R1,R1,R4
BRnz ERROR
AND R2,R2,#0
ADD R2,R2,R1
ADD R2,R2,#-7
BRp ERROR
BR #4

ERROR
  LEA R0,Error_msg_1
  PUTS
  ADD R6,R6,#1

;LD R0,BACKUP_R0_x3900
;LD R1,BACKUP_R1_x3900
LD R2,BACKUP_R2_x3900
LD R3,BACKUP_R3_x3900
LD R4,BACKUP_R4_x3900
LD R5,BACKUP_R5_x3900
;LD R6,BACKUP_R6_x3900
LD R7,BACKUP_R7_x3900

RET
;--------------------------------
;Data for subroutine MENU
;--------------------------------
;BACKUP_R0_x3900 .BLKW #1
;BACKUP_R1_x3900 .BLKW #1
BACKUP_R2_x3900 .BLKW #1
BACKUP_R3_x3900 .BLKW #1
BACKUP_R4_x3900 .BLKW #1
BACKUP_R5_x3900 .BLKW #1
BACKUP_R6_x3900 .BLKW #1
BACKUP_R7_x3900 .BLKW #1

DEC_0 .FILL #-48
NEWLINE1 .STRINGZ "\n"
Error_msg_1	      .STRINGZ "INVALID INPUT\n"
Menu_string_addr  .FILL x6000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
.ORIG x4000

;ST R0,BACKUP_R0_x4000
ST R1,BACKUP_R1_x4000
;ST R2,BACKUP_R2_x4000
ST R3,BACKUP_R3_x4000
ST R4,BACKUP_R4_x4000
ST R5,BACKUP_R5_x4000
ST R6,BACKUP_R6_x4000
ST R7,BACKUP_R7_x4000

AND R2,R2,#0
AND R1,R1,#0
LDI R1,BUSYNESS_ADDR_ALL_MACHINES_BUSY

;PRINT BINARY 
AND R5,R5,#0
ADD R5,R5,#15

NEXT
  ADD R1,R1,#0
  BRn LOOP4
  
  ADD R2,R2,#1
  ;LEA R0,zero
  ;PUTS
  BR END_LOOP4
  
LOOP4
  ;LEA R0,one
  ;PUTS
  
END_LOOP4  
  ADD R1,R1,R1
  ADD R5,R5,#-1
  BRzp NEXT

  
  
;LD R0,BACKUP_R0_x4000
LD R1,BACKUP_R1_x4000
;LD R2,BACKUP_R2_x4000
LD R3,BACKUP_R3_x4000
LD R4,BACKUP_R4_x4000
LD R5,BACKUP_R5_x4000
LD R6,BACKUP_R6_x4000
LD R7,BACKUP_R7_x4000

RET

;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
;BACKUP_R0_x4000 .BLKW #1
BACKUP_R1_x4000 .BLKW #1
;BACKUP_R2_x4000 .BLKW #1
BACKUP_R3_x4000 .BLKW #1
BACKUP_R4_x4000 .BLKW #1
BACKUP_R5_x4000 .BLKW #1
BACKUP_R6_x4000 .BLKW #1
BACKUP_R7_x4000 .BLKW #1
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xCD00

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
.ORIG x4500

;ST R0,BACKUP_R0_x4500
ST R1,BACKUP_R1_x4500
;ST R2,BACKUP_R2_x4500
ST R3,BACKUP_R3_x4500
ST R4,BACKUP_R4_x4500
ST R5,BACKUP_R5_x4500
ST R6,BACKUP_R6_x4500
ST R7,BACKUP_R7_x4500

AND R2,R2,#0
AND R1,R1,#0
LDI R1,BUSYNESS_ADDR_ALL_MACHINES_FREE

;PRINT BINARY 
AND R5,R5,#0
ADD R5,R5,#15


NEXT1
  ADD R1,R1,#0
  BRn LOOP41
  ;LEA R0,zero
  ;PUTS
  BR END_LOOP41
  
LOOP41
  ;LEA R0,one
  ;PUTS
  ADD R2,R2,#1
  
END_LOOP41 
  ADD R1,R1,R1
  ADD R5,R5,#-1
  BRzp NEXT1
  
  
;LD R0,BACKUP_R0_x4500
LD R1,BACKUP_R1_x4500
;LD R2,BACKUP_R2_x4500
LD R3,BACKUP_R3_x4500
LD R4,BACKUP_R4_x4500
LD R5,BACKUP_R5_x4500
LD R6,BACKUP_R6_x4500
LD R7,BACKUP_R7_x4500

RET

;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
;BACKUP_R0_x4500 .BLKW #1
BACKUP_R1_x4500 .BLKW #1
;BACKUP_R2_x4500 .BLKW #1
BACKUP_R3_x4500 .BLKW #1
BACKUP_R4_x4500 .BLKW #1
BACKUP_R5_x4500 .BLKW #1
BACKUP_R6_x4500 .BLKW #1
BACKUP_R7_x4500 .BLKW #1
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xCD00

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
.ORIG x4800

ST R0,BACKUP_R0_x4800
ST R1,BACKUP_R1_x4800
;ST R2,BACKUP_R2_x4800
ST R3,BACKUP_R3_x4800
ST R4,BACKUP_R4_x4800
ST R5,BACKUP_R5_x4800
ST R6,BACKUP_R6_x4800
ST R7,BACKUP_R7_x4800

AND R2,R2,#0
AND R1,R1,#0
LDI R1,BUSYNESS_ADDR_NUM_BUSY_MACHINES
;PRINT BINARY
AND R5,R5,#0
AND R4,R4,#0
ADD R5,R5,#15
ADD R4,R4,#4

LOOP32
  ADD R4,R4,#0
  BRp NEXT2
  
  ;LEA R0,space
  ;PUTS
  
  AND R4,R4,#0
  ADD R4,R4,#4
  ADD R5,R5,#0
  BR END_NEXT2
  
NEXT2
  ADD R1,R1,#0
  BRn LOOP42
  
  ADD R2,R2,#1
  ;LEA R0,zero
  ;PUTS
  BR END_LOOP42
  
LOOP42
  ;LEA R0,one
  ;PUTS
  
END_LOOP42 
  ADD R1,R1,R1
  ADD R4,R4,#-1
  ADD R5,R5,#-1
  END_NEXT2
  BRzp LOOP32
  
  
LD R0,BACKUP_R0_x4800
LD R1,BACKUP_R1_x4800
;LD R2,BACKUP_R2_x4800
LD R3,BACKUP_R3_x4800
LD R4,BACKUP_R4_x4800
LD R5,BACKUP_R5_x4800
LD R6,BACKUP_R6_x4800
LD R7,BACKUP_R7_x4800

RET

;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BACKUP_R0_x4800 .BLKW #1
BACKUP_R1_x4800 .BLKW #1
;BACKUP_R2_x4800 .BLKW #1
BACKUP_R3_x4800 .BLKW #1
BACKUP_R4_x4800 .BLKW #1
BACKUP_R5_x4800 .BLKW #1
BACKUP_R6_x4800 .BLKW #1
BACKUP_R7_x4800 .BLKW #1
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xCD00
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
.ORIG x5100

ST R0,BACKUP_R0_x5100
ST R1,BACKUP_R1_x5100
;ST R2,BACKUP_R2_x5100
ST R3,BACKUP_R3_x5100
ST R4,BACKUP_R4_x5100
ST R5,BACKUP_R5_x5100
ST R6,BACKUP_R6_x5100
ST R7,BACKUP_R7_x5100

AND R2,R2,#0
AND R1,R1,#0
LDI R1,BUSYNESS_ADDR_NUM_FREE_MACHINES
;PRINT BINARY
AND R5,R5,#0
AND R4,R4,#0
ADD R5,R5,#15
ADD R4,R4,#4

LOOP33
  ADD R4,R4,#0
  BRp NEXT3
  
  ;LEA R0,space
  ;PUTS
  
  AND R4,R4,#0
  ADD R4,R4,#4
  ADD R5,R5,#0
  BR END_NEXT3

NEXT3
  ADD R1,R1,#0
  BRn LOOP43
  
  ;ADD R2,R2,#1
  ;LEA R0,zero
  ;PUTS
  BR END_LOOP43
  
LOOP43
  ;LEA R0,one
  ;PUTS
  ADD R2,R2,#1
  
END_LOOP43 
  ADD R1,R1,R1
  ADD R4,R4,#-1
  ADD R5,R5,#-1
  END_NEXT3
  BRzp LOOP33
  
  
LD R0,BACKUP_R0_x5100
LD R1,BACKUP_R1_x5100
;LD R2,BACKUP_R2_x5100
LD R3,BACKUP_R3_x5100
LD R4,BACKUP_R4_x5100
LD R5,BACKUP_R5_x5100
LD R6,BACKUP_R6_x5100
LD R7,BACKUP_R7_x5100

RET


BACKUP_R0_x5100 .BLKW #1
BACKUP_R1_x5100 .BLKW #1
;BACKUP_R2_x5100 .BLKW #1
BACKUP_R3_x5100 .BLKW #1
BACKUP_R4_x5100 .BLKW #1
BACKUP_R5_x5100 .BLKW #1
BACKUP_R6_x5100 .BLKW #1
BACKUP_R7_x5100 .BLKW #1
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xCD00


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
;                          by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
.ORIG x5300			
ST R0,BACKUP_R0_x5300
;ST R1,BACKUP_R1_x5300
;ST R2,BACKUP_R2_x5300
ST R3,BACKUP_R3_x5300
ST R4,BACKUP_R4_x5300
ST R5,BACKUP_R5_x5300
ST R6,BACKUP_R6_x5300
ST R7,BACKUP_R7_x5300

LD R4,GET_INPUT
JSRR R4
AND R0,R0,#0
ADD R0,R0,R1       ;R0  IS THE INPUT


;-R0
ADD R0,R0,#-8
ADD R0,R0,#-8



LDI R3,BUSYNESS_ADDR_MACHINE_STATUS ;R3 IS VALUE

;PRINT BINARY 
AND R5,R5,#0
ADD R5,R5,#15


NEXT5
  ADD R3,R3,#0
  BRn LOOP45
  
  ADD R6,R6,#1   ;R6 IS THE COUNTER
  ;LEA R0,zero
  ;PUTS
  AND R4,R4,#0
  ADD R4,R4,R0   ;R4 IS THE SUBSTITUDE VALUE
  ADD R4,R4,R6
  BRz PRINTBUSY
  BR END_LOOP45
  
LOOP45
  ;LEA R0,one
  ;PUTS
  AND R4,R4,#0
  ADD R6,R6,#1
  ADD R4,R4,R0
  ADD R4,R4,R6
  BRz PRINTFREE
  
END_LOOP45 
  ADD R3,R3,R3
  ADD R5,R5,#-1
  BRzp NEXT5

PRINTBUSY
  AND R2,R2,#0
  ADD R2,R2,#0
  BR #3
  
PRINTFREE
  AND R2,R2,#0
  ADD R2,R2,#1
  
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
LD R0,BACKUP_R0_x5300
;LD R1,BACKUP_R1_x5300
;LD R2,BACKUP_R2_x5300
LD R3,BACKUP_R3_x5300
LD R4,BACKUP_R4_x5300
LD R5,BACKUP_R5_x5300
LD R6,BACKUP_R6_x5300
LD R7,BACKUP_R7_x5300

RET 

BACKUP_R0_x5300 .BLKW #1
;BACKUP_R1_x5300 .BLKW #1
;BACKUP_R2_x5300 .BLKW #1
BACKUP_R3_x5300 .BLKW #1
BACKUP_R4_x5300 .BLKW #1
BACKUP_R5_x5300 .BLKW #1
BACKUP_R6_x5300 .BLKW #1
BACKUP_R7_x5300 .BLKW #1
BUSYNESS_ADDR_MACHINE_STATUS.Fill xCD00
GET_INPUT .FILL x5700
PRINT_NUMBER1 .FILL x5850
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition: 
; The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
.ORIG x5600
		
ST R0,BACKUP_R0_x5600
ST R1,BACKUP_R1_x5600
ST R2,BACKUP_R2_x5600
ST R3,BACKUP_R3_x5600
ST R4,BACKUP_R4_x5600
ST R5,BACKUP_R5_x5600
;ST R6,BACKUP_R6_x5600
ST R7,BACKUP_R7_x5600

LDI R3,BUSYNESS_ADDR_FIRST_FREE ;R3 IS VALUE

;PRINT BINARY 
AND R5,R5,#0
ADD R5,R5,#15
AND R6,R6,#0

NEXT6
  ADD R3,R3,#0
  BRn LOOP46
  
  ADD R6,R6,#1   ;R6 IS THE COUNTER
  ;LEA R0,zero
  ;PUTS
  BR END_LOOP46
  
LOOP46
  ;LEA R0,one
  ;PUTS
  ADD R6,R6,#1  
  BR RETURN
  
END_LOOP46 
  ADD R3,R3,R3
  ADD R5,R5,#-1
  BRzp NEXT6

RETURN
  ADD R6,R6,#0
  
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
LD R0,BACKUP_R0_x5600
LD R1,BACKUP_R1_x5600
LD R2,BACKUP_R2_x5600
LD R3,BACKUP_R3_x5600
LD R4,BACKUP_R4_x5600
LD R5,BACKUP_R5_x5600
;LD R6,BACKUP_R6_x5600
LD R7,BACKUP_R7_x5600

RET 

BACKUP_R0_x5600 .BLKW #1
BACKUP_R1_x5600 .BLKW #1
BACKUP_R2_x5600 .BLKW #1
BACKUP_R3_x5600 .BLKW #1
BACKUP_R4_x5600 .BLKW #1
BACKUP_R5_x5600 .BLKW #1
;BACKUP_R6_x5600 .BLKW #1
BACKUP_R7_x5600 .BLKW #1

BUSYNESS_ADDR_FIRST_FREE .Fill xCD00

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: Get input
; Inputs: None
; Postcondition: 
; The subroutine get up to a 5 digit input from the user within the range [-32768,32767]
; Return Value (R1): The value of the contructed input
; NOTE: This subroutine should be the same as the one that you did in assignment 5
;	to get input from the user, except the prompt is different.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.ORIG x5700

ST R0,BACKUP_R0_x5700
;ST R1,BACKUP_R1_x5700
ST R2,BACKUP_R2_x5700
ST R3,BACKUP_R3_x5700
ST R4,BACKUP_R4_x5700
ST R5,BACKUP_R5_x5700
ST R6,BACKUP_R6_x5700
ST R7,BACKUP_R7_x5700

LD R3,COUNTER
AND R1,R1,#0

START_LOOP
  AND R1,R1,#0
  LEA R0,prompt
  PUTS
  
  GETC
  OUT
  
  AND R5,R5,#0
  ADD R5,R5,R0
  LD R7,NEGDEC0
  ADD R5,R5,R7
  BRn ERROR1
  
  
  AND R5,R5,#0		;CHECK POSITIVE SIGN
  ADD R5,R5,R0
  ADD R5,R5,#-10
  BRz ERROR1
  ADD R5,R5,#-6
  ADD R5,R5,#-16
  ADD R5,R5,#-11
  BRz LOOP_POS
  BRp CHECKNEG
  
  CHECKNEG
    ADD R5,R5,#-2	;CHECK NEGATIVE SIGN
    BRz LOOP_NEG
    BRp CHECKNUM
    
  CHECKNUM
    AND R5,R5,#0
    ADD R5,R5,R0  
    ADD R5,R5,#-16
    ADD R5,R5,#-16
    ADD R5,R5,#-16
    BRn ERROR1
    ADD R5,R5,#-9
    BRp ERROR1
    ADD R3,R3,#-1
    BR LOOP_NUM
    
  LOOP_POS
    GETC
    OUT
    ;CONVERT ASCII TO DECIMAL
    ADD R0,R0,#-10
    BRz HALTPROGRAM2
    ADD R0,R0,#-6
    ADD R0,R0,#-16
    ADD R0,R0,#-16
    BRn ERROR1
    ADD R4,R0,#0
    ADD R4,R4,#-9
    BRp ERROR1
    ADD R6,R1,R1
    ADD R1,R1,R1
    ADD R1,R1,R1 
    ADD R1,R1,R1 
    ADD R1,R6,R1 
    ADD R1,R1,R0
    ADD R3,R3,#-1
   BRp LOOP_POS
   BR HALTPROGRAM2
   
   LOOP_NEG
    GETC
    OUT
    ADD R0,R0,#-10
    BRz TWOCOM
    ADD R0,R0,#-6
    ADD R0,R0,#-16
    ADD R0,R0,#-16
    BRn ERROR1
    ADD R4,R0,#0
    ADD R4,R4,#-9
    BRp ERROR1
    ADD R6,R1,R1 
    ADD R1,R1,R1
    ADD R1,R1,R1 
    ADD R1,R1,R1 
    ADD R1,R6,R1 
    ADD R1,R1,R0
    ADD R3,R3,#-1
   BRp LOOP_NEG
   BR TWOCOM
    
   LOOP_NUM
    ADD R0,R0,#-10
    BRz HALTPROGRAM2
    ADD R0,R0,#-6
    ADD R0,R0,#-16
    ADD R0,R0,#-16
    BRn ERROR1
    ADD R4,R0,#0
    ADD R4,R4,#-9
    BRp ERROR1
    ADD R6,R1,R1 
    ADD R1,R1,R1
    ADD R1,R1,R1 
    ADD R1,R1,R1 
    ADD R1,R6,R1 
    ADD R1,R1,R0
    BR LOOP_POS
    
   TWOCOM
    ADD R2,R2,#1
    NOT R1,R1
    ADD R1,R1,#1
    BR HALTPROGRAM2
  
   ERROR1
    LEA R0,NEWLINE3
    PUTS
    LEA R0,Error_msg_2
    PUTS
   BR START_LOOP
   
  HALTPROGRAM2
    BR #0
    
;--------------------------------
;Data for subroutine Get input
;--------------------------------
LD R0,BACKUP_R0_x5700
;LD R1,BACKUP_R1_x5700
LD R2,BACKUP_R2_x5700
LD R3,BACKUP_R3_x5700
LD R4,BACKUP_R4_x5700
LD R5,BACKUP_R5_x5700
LD R6,BACKUP_R6_x5700
LD R7,BACKUP_R7_x5700

RET

BACKUP_R0_x5700 .BLKW #1
;BACKUP_R1_x5700 .BLKW #1
BACKUP_R2_x5700 .BLKW #1
BACKUP_R3_x5700 .BLKW #1
BACKUP_R4_x5700 .BLKW #1
BACKUP_R5_x5700 .BLKW #1
BACKUP_R6_x5700 .BLKW #1
BACKUP_R7_x5700 .BLKW #1
NEGDEC0  .FILL  #-48
NEGHEX15 .FILL  #-
NEWLINE3 .STRINGZ "\n"
COUNTER .FILL #5
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: print number
; Inputs: R1 the value from input number subroutine
; Postcondition: 
; The subroutine prints the number that is in R1
; Return Value : 
; NOTE: This subroutine should print the number to the user WITHOUT 
;		leading 0's and DOES NOT output the '+' for positive numbers.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.ORIG x5850		
ST R0,BACKUP_R0_x5850
;ST R1,BACKUP_R1_x5850
ST R2,BACKUP_R2_x5850
ST R3,BACKUP_R3_x5850
ST R4,BACKUP_R4_x5850
ST R5,BACKUP_R5_x5850
ST R6,BACKUP_R6_x5850
ST R7,BACKUP_R7_x5850



  
  ADD R1,R1,#1
  
  LOOPD_10_TEMP
    AND R4,R4,#0
    LD R3,NNEG10
    AND R6,R6,#0
    ADD R6,R6,R1
    ADD R6,R6,R3
      BRn PRINTZERO_10D
      BRz PRINT10D
      BRp LOOP_10D
      
  LOOP_10D
    LD R3,NNEG10
    ADD R4,R4,#1
    ADD R1,R1,R3
    ADD R6,R6,R3
      BRp LOOP_10D
      BR PRINT10D
  
  PRINT10D
    AND R0,R0,#0
    ADD R5,R5,#1
    ADD R0,R0,R4
    LD R3,HEX_30
    ADD R0,R0,R3
    OUT
    
  LOOP_1_TEMPD
    AND R4,R4,#0
    LD R3,NNEG1
    AND R6,R6,#0
    ADD R6,R6,R1
    ADD R6,R6,R3
      BRn PRINTZERO_1D
      BRz PRINT1D
      BRp LOOP_1D
      
  LOOP_1D
    LD R3,NNEG1
    ADD R4,R4,#1
    ADD R2,R2,R3
    ADD R6,R6,R3
      BRp LOOP_1D
      BR PRINT1D
  
  PRINT1D
    AND R0,R0,#0
    ADD R5,R5,#1
    ADD R0,R0,R4
    LD R3,HEX_30
    ADD R0,R0,R3
    OUT
    BR HALT0
    
  PRINTZERO_10D
    AND R0,R0,#0
    ADD R5,R5,#0
    BRz #7
    ADD R4,R4,#0
    BRz #0
    ADD R0,R0,#0
    BRz #3
    LD R3,HEX_30
    ADD R0,R0,R3
    OUT
    BR LOOP_1_TEMPD
    
   PRINTZERO_1D
    AND R0,R0,#0
    ADD R5,R5,#0
    BRz #5
    ADD R4,R4,#0
    BRz #0
    LD R3,HEX_30
    ADD R0,R0,R3
    OUT
    BR HALT0
    
   HALT0
    BR #0
   
;=====================================================
LD R0,BACKUP_R0_x5850
;LD R1,BACKUP_R1_x5850
LD R2,BACKUP_R2_x5850
LD R3,BACKUP_R3_x5850
LD R4,BACKUP_R4_x5850
LD R5,BACKUP_R5_x5850
LD R6,BACKUP_R6_x5850
LD R7,BACKUP_R7_x5850

RET

BACKUP_R0_x5850 .BLKW #1
;BACKUP_R1_x5850 .BLKW #1
BACKUP_R2_x5850 .BLKW #1
BACKUP_R3_x5850 .BLKW #1
BACKUP_R4_x5850 .BLKW #1
BACKUP_R5_x5850 .BLKW #1
BACKUP_R6_x5850 .BLKW #1
BACKUP_R7_x5850 .BLKW #1

NNEG10 .FILL #-10
NNEG1 .FILL #-1
HEX30 .FILL x30
HEX_30 .FILL x0030
NEWLINE4 .STRINGZ "\n"
;--------------------------------

;Data for subroutine print number
;--------------------------------
  

.ORIG x6000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xCD00			; Remote data
BUSYNESS .FILL xABCD	; <----!!!VALUE FOR BUSYNESS VECTOR!!!

;---------------	
;END of PROGRAM
;---------------	
.END
