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
    LDR R0, =num1       ; Load address of first 128-bit number
    LDR R1, =num2       ; Load address of second 128-bit number
    LDR R2, =sum        ; Load address to store the result

    LDR R3, [R0]        ; Load lower 32 bits of num1
    LDR R4, [R1]        ; Load lower 32 bits of num2
    ADDS R5, R3, R4     ; Add LSBs, set carry flag
    STR R5, [R2]        ; Store result LSB

    LDR R3, [R0, #4]    ; Load second 32-bit chunk of num1
    LDR R4, [R1, #4]    ; Load second 32-bit chunk of num2
    ADCS R5, R3, R4     ; Add with carry
    STR R5, [R2, #4]    ; Store second chunk

    LDR R3, [R0, #8]    ; Load third 32-bit chunk of num1
    LDR R4, [R1, #8]    ; Load third 32-bit chunk of num2
    ADCS R5, R3, R4     ; Add with carry
    STR R5, [R2, #8]    ; Store third chunk

    LDR R3, [R0, #12]   ; Load highest 32-bit chunk of num1
    LDR R4, [R1, #12]   ; Load highest 32-bit chunk of num2
    ADCS R5, R3, R4     ; Add with carry
    STR R5, [R2, #12]   ; Store highest chunk

    MRS R6, APSR        ; Move status register to R6
    LSR R6, R6, #29     ; Extract carry bit (bit 29)
    AND R6, R6, #1      ; Mask out everything except carry
    LDR R7, =carry      ; Load carry memory location
    STR R6, [R7]        ; Store carry value (0 or 1)

STOP
    B STOP

    AREA data, DATA, READWRITE
num1 DCD 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0x7FFFFFFF  ; 128-bit number (largest possible positive)
num2 DCD 0x00000001, 0x00000000, 0x00000000, 0x80000000  ; 128-bit number (smallest possible negative)

sum  DCD 0, 0, 0, 0   ; Placeholder for result (128-bit)
carry DCD 0           ; Placeholder for carry

    END
