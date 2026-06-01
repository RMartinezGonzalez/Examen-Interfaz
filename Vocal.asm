TITLE SUMAR DOS NEW
.286

.MODEL SMALL
include Libreria.lib

.STACK

.DATA
    vocales DB 'a', 'e', 'i', 'o', 'u'
    colores DB 0FH, 0FH, 0FH, 0FH, 0FH
    flechasColores DB 00H, 00H, 00H, 00H, 00H
    i DB 0
    msgCaracter DB 'Ingrese un caracter a encontrar: $'
    msgPedirCadena DB 'Ingrese una cadena: $'
    cadena DB 10 DUP (?), '$'
    largo EQU $ - cadena - 1

    encontrados DB largo DUP (?)

    msgEncontrado DB 'Se ha encontrado el caracter en la posicion: $'
    msgNoEncontrado DB 'No se ha encontrado el caracter: $'

    ;msgText DB 'El largo de la cadena es: $'
    
.CODE


Main PROC FAR
    CALL INICIO

MOSTRAR_TODO:
    CALL LIMPIAR
    VACIAR_CADENA cadena
    
    MOV SI, 0
    MOV CX, 5
MOSTRAR_FLECHAS:
    POSICIONAR_INC 11, 34, i
    ADD i, 3
    IMPRIMIR_CARACTER_COLOR 'v', flechasColores[SI]
    INC SI
    LOOP MOSTRAR_FLECHAS
    MOV i, 0


    MOV SI, 0
    MOV CX, 5
MOSTRAR_VOCALES:
    POSICIONAR_INC 12, 34, i
    ADD i, 3
    IMPRIMIR_CARACTER_COLOR vocales[SI], colores[SI]
    INC SI
    LOOP MOSTRAR_VOCALES
    MOV i, 0

;==========================================
    POSICIONAR 24,0
    IMPRIMIR msgPedirCadena
    LEER_CADENA cadena, largo
    PUSH SI
    ;IMPRIMIR cadena


    ;CALL SALTO
    ;IMPRIMIR msgText
    ;MOV AX, SI
    ;ADD AX, 30H
    ;IMPRIMIR_CARACTER al

    ;CALL SALTO
    IMPRIMIR msgCaracter
    CALL PEDIR_CARACTER

    PUSH AX


    MOV DI, OFFSET cadena
    MOV BX, DI
    MOV CX, SI
SCAREP:

    CLD

    REPNE SCASB
    JNZ NOENCONTRADO

    PUSH AX

    CALL SALTO
    IMPRIMIR msgEncontrado

    DEC DI
    MOV DX, DI
    
    SUB DX, BX


    ADD DX, 30H
    IMPRIMIR_CARACTER DL

    INC DI

    POP AX
    CMP CX, 0
    INC i
    JNE SCAREP
    MOV i, 0
    JMP NEXT
    
NOENCONTRADO:
    CMP i, 0
    MOV i, 0
    JNE NEXT
    CALL SALTO
    IMPRIMIR msgNoEncontrado

NEXT:
    CALL PEDIR_CARACTER
    POP AX

    MOV SI, 0
    MOV CX, 5
COMPARAR:
    CMP AL, 1BH
    JE FIN
    CMP AL, vocales[SI]

    JE CAMBIAR
    INC SI
    LOOP COMPARAR
    JMP MOSTRAR_TODO

CAMBIAR:
    PUSH SI
    MOV SI, 0
    MOV CX, 5
LIMPIAR_FLECHAS:
    MOV flechasColores[SI], 0
    INC SI
    LOOP LIMPIAR_FLECHAS

    POP SI
    INC colores[SI]
    MOV AX, SI
    MOV AH, 3
    MUL AH
    ADD AX, 34
    MOV i, AL

    POSICIONAR 11, i
    MOV flechasColores[SI], 0FH
    IMPRIMIR_CARACTER_COLOR 'v', flechasColores[SI]
    MOV i, 0

    JMP MOSTRAR_TODO

FIN:
    CALL SALIR

Main ENDP

END Main