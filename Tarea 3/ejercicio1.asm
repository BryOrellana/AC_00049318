	org 100h
	section .text

	XOR AX, AX
	XOR BX, BX
	XOR SI,SI
	MOV BL, 8h

	mov     byte[200h], 0d
	mov     byte[201h], 0d
	mov     byte[202h], 0d
	mov     byte[203h], 4d
	mov     byte[204h], 9d
	mov     byte[205h], 3d
	mov     byte[206h], 1d
	mov     byte[207h], 8d

	jmp iterar 

iterar:
	;Compara para dividir
	CMP SI, 008h
	JE division

	ADD AL, [200h+SI]
	INC SI ;Suma uno cada vez que se entra a iterar
	LOOP iterar

division:
	DIV BL
	MOV [020AH], AL
	jmp exit
exit:
	int 20h