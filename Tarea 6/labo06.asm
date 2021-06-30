; BRYAN ALEXIS ORELLANA CABRERA 00049318
; MAIN
	org 	100h

	section	.text

	; print msg1
	mov 	DX, msg1
	call  	EscribirCadena

	; input clave
	mov 	BP, clave
	call  	LeerCadena

	call	EsperarTecla

	int 	20h

	section	.data

msg1		db	"Ingresa una clave (max: 5 caracteres): ", "$"		;Mensaje que pide la clave
msg2 		db 	"BIENVENIDO", "$"				;Mensaje que se muestra si la clave es correcta
msg3 	    db 	"INCORRECTO", "$"				;Mensaje que se muestra si la clave es erronea
claveCMP	db 'clave', "$"						;La clave de 5 digitos espera que debe ingresar el usuario
clave 	times 	5  	db	" " 					;Se crea un espacio con 5 digitos vacios para guardar la clave que ingrese el usuario

EsperarTecla:			; Espera que se escriba una tecla y la retorna
        mov     AH, 01h         
        int     21h
        ret

LeerCadena:				; Leer cadena de texto desde el teclado
        xor     SI, SI          ; SI = 0
while:  
        call    EsperarTecla    ;Llamada a esperar tecla.
        cmp     AL, 0x0D        
        je      comparar        ;Si AL es igual al caracter enterKey salta a comparar la clave ingresada     
        mov     [BP+SI], AL   	;Si no se copia el caracter ingresado en AL en BP+SI			
        inc     SI              ;Incrementa SI
        jmp     while           ;Se retorna al while

EscribirCadena:			; Escribe la cadena.
	mov 	AH, 09h
	int 	21h
	ret

comparar:				; Compara letra por letra la clave ingresada con la esperada
	xor SI, SI  				; SI= 0
loop:	
	mov AL, [BP+SI]				; Se guarda en AL lo que es te en BP+SI
	cmp AL, [claveCMP+SI]		; Se compara si lo que esta en AL es igual a la clave esperada en la pos = SI = 0,1,2,3,4
	jne error					; Si alguna letra no es igual se salta a error

	cmp si, 4					; Se compara SI con 4
	je correcto					; Si se cumple que SI es 4 significa que todas las letras de la contraseña son iguales a lo esperado entonces se salta a correcto
	
	inc SI						; Si no se cumple SI=4 se incrementa SI
	jmp loop					; Se salta a loop de nuevo para repetir el proceso.

correcto:			; print msg2
	mov 	DX, msg2
	call 	EscribirCadena
	jmp exit

error:				; print incorrecto
	mov 	DX, msg3
	call 	EscribirCadena
	jmp exit

exit:
	mov 	byte [BP+SI], "$"	
	ret