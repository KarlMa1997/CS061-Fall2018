;=================================================
; Name: Kaihang Ma	
; Email:  kma023@ucr.edu
; GitHub username: KarlMa1997
; 
; Lab: lab 6
; Lab section: 028
; TA: Jason
;=================================================
.orig x3000
LD R3,COUNTER
LD R1,INIT
START_LOOP
  LEA R0,PROMPT
  PUTS
  LEA R0,NEWLINE
  PUTS
  
  LD R4,CHECKB
  GETC
  OUT
  
  ADD R5,R0,R4
  BRz LOOP
  BR ERROR1
  
    ERROR1
      LEA R0,ERROR_1
      PUTS
      LEA R0,NEWLINE
      PUTS
      BR START_LOOP

    LOOP
      AND R5,R5,#0
      GETC
      OUT
      ;SUBSTRACT SPACE
      ADD R5,R0,#0
      ADD R5,R5,#-16
      ADD R5,R5,#-16
      BRz LOOP
      BRn ERROR2
      BRp COUT2
      
    COUT2
      AND R5,R5,#0
      ;SUBSTRACT ONE
      ADD R5,R0,#0
      ADD R5,R5,#-16
      ADD R5,R5,#-16
      ADD R5,R5,#-16
      ADD R5,R5,#-1
      BRp ERROR2
      BR COUT3
      
    ERROR2
      LEA R0,ERROR_2
      PUTS
      LEA R0,NEWLINE
      PUTS
      BR LOOP
      
    COUT3
      ;ADD 0 OR 1 FROM USER TO CURRENT UMBER
      ADD R0,R0,#-16
      ADD R0,R0,#-16
      ADD R0,R0,#-16
      ADD R1,R1,R1
      ADD R1,R1,R0
      ;DECREMENT COUNTER
      ADD R3,R3,#-1
      BRp LOOP
      
    END_LOOP

    LD R6,SUB_PRINT_BINARY_3200
    JSRR R6
END_START_LOOP

HALT

    
    

ERROR_1 .STRINGZ "YOUR INPUT IS NOT 'b', GOTO START"
ERROR_2 .STRINGZ "YOUR INPUT IS NOT '0' OR '1'"
NEWLINE .STRINGZ "\n"
PROMPT .STRINGZ "ENTER A 16-BIT 2'S COMPLEMENT BINARY NUMBER"
CHECKB .FILL #-98
COUNTER .FILL #16
INIT .FILL #0


SUB_PRINT_BINARY_3200 .FILL x3200
;============================================
;Subroutine: SUB_PRINT_BINARY_3200
;Parameter: R1
;Postcondition: subroutine for printing binary
;return value: none

.orig x3200
ST R1,BACKUP_R1_x3200
ST R4,BACKUP_R4_x3200
ST R5,BACKUP_R5_x3200
ST R7,BACKUP_R7_x3200

AND R5,R5,#0
AND R4,R4,#0
ADD R5,R5,#15
ADD R4,R4,#4

LEA R0,NEWLINE2
PUTS

LOOP3
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

  BRn LOOP4
    LEA R0,strzero
    PUTS
    
  BR END_LOOP4
    LOOP4
    LEA R0,strone
    PUTS
  END_LOOP4
  
    ADD R1,R1,R1
    ADD R4,R4,#-1
    ADD R5,R5,#-1
    END_NEXT
BRzp LOOP3
LEA R0,NEWLINE2
PUTS
;=====================================
LD R1,BACKUP_R1_x3200
LD R4,BACKUP_R4_x3200
LD R5,BACKUP_R5_x3200
LD R7,BACKUP_R7_x3200
RET

;local data_x3200
strone .STRINGZ "1"
strzero .STRINGZ "0"
space .STRINGZ " "
NEWLINE2 .STRINGZ "\n"
BACKUP_R1_x3200 .BLKW #1
BACKUP_R4_x3200 .BLKW #1
BACKUP_R5_x3200 .BLKW #1
BACKUP_R7_x3200 .BLKW #1
