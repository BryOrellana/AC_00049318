        org     100h

        section .text

        XOR SI, SI;                           ;Contadores
        XOR DI, DI;
        XOR BX, BX;
        XOR CX, CX;
        XOR DX, DX;

        MOV     BP, arrByte     ; BP = puntero a arrByte
        CALL    ParImpar        ; llama función

        int     20h

        section .data

arrByte db      01,02,03,04,05,06,07,08,09,06     
divs equ        02

ParImpar:
        MOV     BL, divs       
iterar:  
        CMP     SI,10
        JE      end

        XOR     AX, AX; 
        MOV     AL, [BP+SI]
        MOV     BH,AL
        DIV     BL
        INC     SI

        CMP     AH, 0
        JE      par
        JNE     impar
        

par:
        MOV DI, CX    
        MOV     [300h+ DI], BH
        INC     DI
        MOV     CX, DI   
        jmp     iterar

impar:
        MOV DI, CX    
        MOV     [320h+DI], BH
        INC     DI
        MOV     DX, DI   
        jmp     iterar

end:    
        ret                     


