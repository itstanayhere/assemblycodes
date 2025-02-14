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
    LDR R0, =src       ; Load address of src array
    MOV R1, #0         ; Initialize sum
    MOV R2, #10        ; Loop counter
    LDR R4, =dst       ; Load address of dst
    LDR R6, =carry     ; Load address of carry storage

LOOP
    LDR R3, [R0], #4   ; Load word from src, increment address
    ADCS R1, R3        ; Add with carry
    SUBS R2, R2, #1    ; Decrement loop counter
    BNE LOOP           ; Repeat until R2 == 0

    STR R1, [R4]       ; Store final sum

    MRS R5, APSR       ; Move status register to R5
    LSR R5, R5, #29    ; Extract Carry Flag (bit 29)
    AND R5, R5, #1     ; Mask to get only carry bit
    STR R5, [R6]       ; Store carry bit in memory

STOP 
    B STOP

src DCD 0x1A2B3C4D, 0x89ABCDEF, 0x12345678, 0x87654321, 0xDEADBEEF,0x0F1E2D3C, 0xAABBCCDD, 0x13579BDF, 0xCAFEBABE, 0xFEEDC0DE

    AREA data, DATA, READWRITE  ; Correct memory section
dst   DCD 0   ; Memory location for sum
carry DCD 0   ; Memory location for carry flag

    END
