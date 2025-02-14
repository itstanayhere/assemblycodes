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
	LDR R0,=0x12345678
	MOV R2,#0
SOD
    AND R1, R0, #0xF
    ADD R2, R2, R1       
    LSR R0, R0, #4       
    CMP R0, #0           
    BNE SOD
STOP 
	B STOP
	END
