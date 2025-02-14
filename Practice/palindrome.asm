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
    LDR R0, =0x11111111
	MOV R5,R0
    MOV R1, R0 
    MOV R4, #0
    MOV R2, #0xF
	MOV R6,#0
LOOP
    AND R3, R1, R2
    LSL R4, R4, #4
    ORR R4, R4, R3
    LSR R1, R1, #4
    CMP R1, #0
    BNE LOOP
	CMP R4,R5
	BEQ FLAG
	BNE STOP
FLAG
	MOV R6,#1
STOP
    B STOP
	END
