    AREA RESET, DATA, READONLY
    EXPORT __Vectors
__Vectors
    DCD 0x40001000
    DCD Reset_Handler
    ALIGN

    AREA ascend, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler
Reset_Handler
	MOV R0,#7 ;dividend
	MOV R1,#2 ;divisor
	MOV R2,#0 ;quotient
	B DIVIDE
DIVIDE
	;put rest of the code needed here
	SUB R0,R0,R1
	ADD R2,#1
	CMP R0,R1
	BLO STOP
	BNE DIVIDE
	BX LR
STOP 
	B STOP
	END
