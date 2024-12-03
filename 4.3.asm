include 'emu8086.inc'

org 100h        

MOV AX, 0       
MOV BX, 0       

START:
    CALL INPUT_NUMBER
    CALL CHECK_ODD_EVEN   
    CALL ASK_CONTINUE     

    CMP AL, 'Y'           
    JE START              
    CMP AL, 'y'           
    JE START              

    MOV AH, 4Ch
    INT 21H

INPUT_NUMBER PROC
    MOV AH, 1            
    INT 21H              
    SUB AL, '0'          
    MOV BX, AX           
    RET
INPUT_NUMBER ENDP

CHECK_ODD_EVEN PROC
    MOV AX, BX           
    TEST AX, 1           
    JZ EVEN              
    MOV DX, OFFSET ODD_MESSAGE
    CALL PRINT_STRING
    RET

EVEN:
    MOV DX, OFFSET EVEN_MESSAGE
    CALL PRINT_STRING
    RET
CHECK_ODD_EVEN ENDP

ASK_CONTINUE PROC
    MOV AH, 9            
    MOV DX, OFFSET CONTINUE_PROMPT
    INT 21H              
    MOV AH, 1            
    INT 21H              
    RET
ASK_CONTINUE ENDP

PRINT_STRING PROC
    MOV AH, 9
    INT 21H
    RET
PRINT_STRING ENDP

ODD_MESSAGE DB '   The number is odd.$'
EVEN_MESSAGE DB '   The number is even.$'
CONTINUE_PROMPT DB '    Do you want to continue? (Y/N): $'

ret
