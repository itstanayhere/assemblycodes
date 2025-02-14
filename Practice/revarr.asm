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
    LDR R0, =src          ; R0 points to start of array (src[0])
    LDR R1, =src + 36     ; R1 points to last element (src[9])

    MOV R3, #5            ; Loop counter (only 5 swaps needed)

REVARR
    LDR R2, [R0]          ; Load value from start pointer (src[i])
    LDR R4, [R1]          ; Load value from end pointer (src[9-i])

    STR R4, [R0]          ; Store src[9-i] into src[i]
    STR R2, [R1]          ; Store src[i] into src[9-i]

    ADD R0, R0, #4        ; Move start pointer forward
    SUB R1, R1, #4        ; Move end pointer backward

    SUBS R3, R3, #1       ; Decrement swap counter
    BNE REVARR            ; If not done, repeat

STOP 
    B STOP

src DCD 0x1A2B3C4D, 0x89ABCDEF, 0x12345678, 0x87654321, 0xDEADBEEF,0x0F1E2D3C, 0xAABBCCDD, 0x13579BDF, 0xCAFEBABE, 0xFEEDC0DE

    END
