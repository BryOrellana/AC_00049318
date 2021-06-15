;Bryan Alexis Orellana Cabrera #00049318
org 100h

    section .text
    MOV SI, 0
    MOV DI, 0

    MOV DL, 35

    MOV byte[200h], 8
    MOV byte[201h], 10
    MOV byte[202h], 12
    MOV byte[203h], 14

    call modotexto

        iterar:
        MOV DH, [200h+DI]
        call movercursor 
        MOV CL, [nombre+SI] 
        call escribirCar
        XOR CL, CL
        INC DL 
        INC SI
        
        CMP SI, 6
        JE CmpEspacio

        CMP SI, 13
        JE CmpEspacio

        CMP SI, 22
        JE CmpEspacio

        CMP SI, 30
        JE esperartecla

        jmp iterar

        exit:
        int 20h

        esperartecla:
        MOV AH, 00h 
        INT 16h
        jmp exit

        CmpEspacio:
        INC DI
        MOV DL,35
        jmp iterar 
        
        modotexto: 
        MOV AH, 0h
        MOV AL, 03h
        INT 10h
        RET

        movercursor:
        MOV AH, 02h
        MOV BH, 0h 
        INT 10h
        RET

        escribirCar:
        MOV AH, 0Ah 
        MOV AL, CL 
        MOV BH, 0h
        MOV CX, 1h 
        INT 10h
        RET

    section .data

    nombre DB 'Bryan Alexis Orellana Cabrera'