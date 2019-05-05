S0  SEGMENT STACK
    DW  30 DUP(?)
TOP LABEL   WORD
S0  ENDS

S1  SEGMENT    
TITLE0 DB 13,10,'NO.17041126','$'   
TITLE1 DB 13,10,'NA.XIONGLEI','$'  
TITLE2 DB 'ORIGIN:','$' 
TITLE3 DB 13,10,'AFTER:','$'  
TITLE4 DB 13,10,'$'       
TITLE5 DB 13,10,'PROCESS:','$'
ARY DW  1,22,31,4,5,6,78,9,52,3,2,23,54,32,42,55,66,44,33,82
CRLF    DB  0DH, 0AH, 24H
N   DW  0
S1  ENDS  


DISPMESSAGE MACRO MESSGE
    LEA DX,MESSGE
    MOV AH,09H
    INT 21H
ENDM     
          

S2  SEGMENT
    ASSUME  SS:S0, DS:S1, CS:S2, ES:S1
P   PROC    FAR
    MOV AX, S0
    MOV SS, AX
    LEA SP, TOP

    MOV AX, S1
    MOV DS, AX

    MOV AX, S1
    MOV ES, AX

    LEA SI, ARY

    XOR DX, DX    
    
    LEA SI, ARY
    MOV DI, SI
    ADD DI, 2

    MOV CL, 20
    MOV CH, 20   
    
    DISPMESSAGE TITLE2
    CALL    PRINT        

CMPA:;±È½Ï´óÐ¡   
    MOV BX, [DI]
    CMP BX, [DI-2]  ;BX´ó£¬½øÈëCON
    JA  CON
    MOV DX, [DI-2]
    PUSH    DX
    MOV [DI-2], BX
    POP DX
    MOV [DI], DX   

CON: ;½»»»Ë³Ðò       
    ADD DI, 2
    DEC CH       
    CMP CH, 0
    JNE CMPA

    MOV DI, SI
    ADD DI, 2
    DEC CL
    MOV CH, CL
    CMP CL, 1 

    JNE CMPA
    
    DISPMESSAGE TITLE3
    CALL    PRINT   
    DISPMESSAGE TITLE0
    DISPMESSAGE TITLE1

    ;ÒÔÏÂÎªÊ®½øÖÆÊä³öARYÖÐµÄÊý


    MOV AH, 4CH
    INT 21H

P   ENDP

PRINT   PROC    NEAR
    PUSH    SI
    PUSH    CX
    PUSH    AX
    PUSH    DX
    LEA DX, CRLF

    LEA SI, ARY
    MOV CX, 20
L1: MOV AX, [SI]
    MOV N, AX
    CALL OUTPUT
    ADD SI, 2
    MOV DX, 20H
    MOV AH, 2
    INT 21H
    LOOP    L1

    POP DX
    POP AX
    POP CX
    POP SI
    RET

PRINT   ENDP

OUTPUT  PROC    NEAR
    PUSH    AX
    PUSH    BX
    PUSH    CX
    PUSH    DX

    XOR CX, CX 
    MOV AX, N
    MOV BX, 10
L2: XOR DX, DX
    DIV BX
    PUSH    DX
    INC CX
    CMP AX, 0
    JNE L2

L3: POP DX
    ADD DX, 30H
    MOV AH, 2
    INT 21H
    LOOP    L3

    POP DX
    POP CX
    POP BX
    POP AX
    RET
OUTPUT  ENDP

S2  ENDS
    END P
