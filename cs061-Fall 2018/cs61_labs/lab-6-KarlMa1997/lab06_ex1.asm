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
LD R2, ptr
LD R3, size
LD R1, START_VALUE

LOOP
  STR R1,R2,#0
  ADD R1,R1,R1
  ADD R2,R2,#1
  ADD R3,R3,#-1
  BRp LOOP
END_LOOP

LEA R0,NEWLINE
PUTS

LD R2, ptr
LD R3, size

LOOP2
  LDR R1,R2,#0
  LD R6,SUB_PRINT_BINARY_3200
  JSRR R6
  ADD R2,R2,#1
  ADD R3,R3,#-1
  BRp LOOP2
END_LOOP2 

HALT


;local data
START_VALUE	.FILL #1
ptr .FILL x4000
size .FILL #10
NEWLINE .STRINGZ "\n"
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
LD R0,BACKUP_R0_x3200
RET

;local data_x3200
strone .STRINGZ "1"
strzero .STRINGZ "0"
space .STRINGZ " "
NEWLINE2 .STRINGZ "\n"
BACKUP_R0_x3200 .BLKW #1
BACKUP_R1_x3200 .BLKW #1
BACKUP_R4_x3200 .BLKW #1
BACKUP_R5_x3200 .BLKW #1
BACKUP_R7_x3200 .BLKW #1
