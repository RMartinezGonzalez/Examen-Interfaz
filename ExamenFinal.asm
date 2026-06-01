TITLE Menu RMG
.286

.MODEL SMALL
.STACK

.DATA
    NOTA_DO4  DW  4560    ; ~261.63 Hz
    NOTA_RE4  DW  4063
    NOTA_MI4  DW  3619    ; ~329.63 Hz
    NOTA_FA4  DW  3416
    NOTA_SOL4 DW  3019    ; ~392.00 Hz
    NOTA_LA4  DW  2711
    NOTA_SI4  DW  2415
    NOTA_DO5  DW  2280    ; ~261.63 Hz
    NOTA_RE5  DW  2032
    NOTA_MI5  DW  1810    ; ~329.63 Hz
    NOTA_FA5  DW  1708
    NOTA_SOL5 DW  1522    ; ~392.00 Hz
    NOTA_LA5  DW  1356
    NOTA_SI5  DW  1208


    menu1 DB 'MENU$'
    menu2 DB'1. Sumar$'
    menu3 DB'2. Restar$'
    menu4 DB'3. Salir$'
    msgSumar db 'Elegiste la opcion Sumar$'
    msgNum1 db 'Ingrese el primer numero: $'
    msgNum2 db 'Ingrese el segundo numero: $'
    msgSuma db 'La suma de ambos numeros es: $'
    msgRestar db 'Elegiste la opcion Restar$'
    msgResta db 'La resta del mayor menos el menor numero es: $'
    ;msgRSuma db 'La resta de ambos numeros es: $'
    ;msgRResta db 'La resta del mayor menos el menor numero es: $'
    msgSalir db 'Saliendo del programa$'

    msgEsperaSumar DB 'Click para confimar la suma$'
    msgEsperaRestar DB 'Click para confimar la resta$'
    msgEsperaSalir DB 'Dea click aqui para salir$'


.CODE
include Libreria.lib

Main PROC FAR
    CALL INICIO

    CALL INICIAR_CLICK

MOSTRAR_MENU:
    CALL OCULTAR_CLICK
    CALL LIMPIAR


    POSICIONAR 10,38
    IMPRIMIR menu1

    POSICIONAR 12,36
    IMPRIMIR menu2
    
    POSICIONAR 13,36
    IMPRIMIR menu3

    POSICIONAR 14,36
    IMPRIMIR menu4
    
    CALL MOSTRAR_CLICK
    CALL MOSTRAR_CLICK

ESPERAR_IZQUIERDO:
    CALL CLICK
    CMP BX, 2
    JE FIN

    CMP BX, 1
    JNE ESPERAR_IZQUIERDO

    CALL CONVERTIR

    CMP DX, 12
    JE OPCION1
    CMP DX, 13
    JE OPCION2
    CMP DX, 14
    JE OPCION3

    JMP SONAR_NOTA_FUERA

    JMP ESPERAR_IZQUIERDO

OPCION1:
    CMP CX, 36
    JB SONAR_NOTA_FUERA
    CMP CX, 43
    JA SONAR_NOTA_FUERA




    POSICIONAR 12, 36
    IMPRIMIR_COLOR menu2
    CALL DELAY




    JMP MENU_SUMAR


OPCION2:
    CMP CX, 36  
    JB SONAR_NOTA_FUERA
    CMP CX, 44
    JA SONAR_NOTA_FUERA

    ;MOV BX, NOTA_RE4
    ;CALL TOCAR_NOTA
    ;CALL DELAY_CORTO
    ;CALL APAGAR_BOCINA


    POSICIONAR 13, 36
    IMPRIMIR_COLOR menu3
    CALL DELAY



    JMP MENU_RESTAR



OPCION3:
    CMP CX, 36
    JB SONAR_NOTA_FUERA
    CMP CX, 43
    JA SONAR_NOTA_FUERA


    POSICIONAR 14, 36
    IMPRIMIR_COLOR menu4
    CALL DELAY


    JMP FIN

MENU_SUMAR:
    CALL OCULTAR_CLICK
    CALL LIMPIAR

    POSICIONAR 10, 26
    IMPRIMIR msgEsperaSumar
    POSICIONAR 15, 26
    IMPRIMIR msgEsperaSalir

    CALL MOSTRAR_CLICK
    CALL MOSTRAR_CLICK


ESPERAR_IZQUIERDO_SUMAR:
    CALL CLICK

    CMP BX, 1
    JNE ESPERAR_IZQUIERDO_SUMAR

    CALL CONVERTIR


    CMP DX, 15
    JE VALIDAR_SALIR_SUMA

    CMP DX, 10
    JNE ESPERAR_IZQUIERDO_SUMAR
    JMP VALIDAR_SUMAR

VALIDAR_SALIR_SUMA:
    CMP CX, 26
    JB ESPERAR_IZQUIERDO_SUMAR
    CMP CX, 50
    JA ESPERAR_IZQUIERDO_SUMAR
    JMP MOSTRAR_MENU

VALIDAR_SUMAR:

    CMP CX, 26
    JB ESPERAR_IZQUIERDO_SUMAR
    CMP CX, 52
    JA ESPERAR_IZQUIERDO_SUMAR

    JMP SUMAR

MENU_RESTAR:
    CALL OCULTAR_CLICK
    CALL LIMPIAR

    POSICIONAR 10, 26
    IMPRIMIR msgEsperaRestar
    POSICIONAR 15, 26
    IMPRIMIR msgEsperaSalir
    
    CALL MOSTRAR_CLICK
    CALL MOSTRAR_CLICK

ESPERAR_IZQUIERDO_RESTAR:
    CALL CLICK

    CMP BX, 1
    JNE ESPERAR_IZQUIERDO_RESTAR

    CALL CONVERTIR


    CMP DX, 15
    JE VALIDAR_SALIR_RESTA

    CMP DX, 10
    JNE ESPERAR_IZQUIERDO_RESTAR
    JMP VALIDAR_RESTAR

VALIDAR_SALIR_RESTA:
    CMP CX, 26
    JB ESPERAR_IZQUIERDO_RESTAR
    CMP CX, 50
    JA ESPERAR_IZQUIERDO_RESTAR
    JMP MOSTRAR_MENU

VALIDAR_RESTAR:

    CMP CX, 26
    JB ESPERAR_IZQUIERDO_RESTAR
    CMP CX, 53
    JA ESPERAR_IZQUIERDO_RESTAR

    JMP RESTAR

SUMAR:

    CALL OCULTAR_CLICK
    CALL LIMPIAR
    POSICIONAR 24, 0
    IMPRIMIR msgSumar
    CALL SALTO
    CALL SALTO
    IMPRIMIR msgNum1
    CALL PEDIR_CARACTER
    SUB AL, 30H
    
    ;PUSH AX
    ;CALL SALTO
    ;POP AX
    ;IMPRIMIR_CARACTER AL

    MOV BL, AL
    CALL SALTO
    IMPRIMIR msgNum2
    CALL PEDIR_CARACTER
    SUB AL, 30H
    ;IMPRIMIR_CARACTER AL
    ADD AL, BL
    ADD AL, 30H
    PUSH AX
    CALL SALTO
    IMPRIMIR msgSuma
    POP AX
    IMPRIMIR_CARACTER AL

    CALL SALTO
    IMPRIMIR msgSalir
    
    CALL DELAY
    JMP MENU_SUMAR

RESTAR:
    CALL OCULTAR_CLICK
    CALL LIMPIAR
    POSICIONAR 24, 0
    IMPRIMIR msgRestar
    CALL SALTO
    CALL SALTO
    IMPRIMIR msgNum1
    CALL PEDIR_CARACTER
    SUB AL, 30H

    MOV BL, AL
    CALL SALTO
    IMPRIMIR msgNum2
    CALL PEDIR_CARACTER
    SUB AL, 30H

    CMP BL, AL
    JB PRIMERO_MENOR 

    SUB BL, AL
    ADD BL, 30H
    JMP PRIMERO_MAYOR

PRIMERO_MENOR:

    SUB AL, BL
    ADD AL, 30H
    PUSH AX
    CALL SALTO
    IMPRIMIR msgResta
    POP AX
    IMPRIMIR_CARACTER AL
    JMP RESTA_FINAL
    
PRIMERO_MAYOR:
    CALL SALTO
    IMPRIMIR msgResta
    IMPRIMIR_CARACTER BL

RESTA_FINAL:
    CALL SALTO
    IMPRIMIR msgSalir

    CALL DELAY
    JMP MENU_RESTAR

SONAR_NOTA_FUERA:
    MOV BX, NOTA_DO4
    CALL TOCAR_NOTA
    CALL DELAY_CORTO
    CALL APAGAR_BOCINA
    JMP ESPERAR_IZQUIERDO


ESPERAR:
    CALL CLICK
    CMP BX, 1

    JE ESPERAR

    JMP ESPERAR_IZQUIERDO

FIN:
    ;MOV BX, NOTA_SOL4
    ;CALL TOCAR_NOTA
    ;CALL DELAY_CORTO
    ;CALL APAGAR_BOCINA

    CALL OCULTAR_CLICK
    CALL LIMPIAR
    POSICIONAR 13, 30
    IMPRIMIR msgSalir
    CALL DELAY
    CALL LIMPIAR
    POSICIONAR 24, 0
    CALL SALIR
    
Main ENDP

END Main

;Buscar el AAA para imprimir numeros más de 1 digito
;;Identifique el mayor para restar el msgEncontrado
;;Esta en un ciclo para seguir pidiendo numero, salir unicamente mostrando un botón y dando Clickee
;;Darle un delay
;;Cada que le de a sumar nota de DO, retar RE, Salir SOL
;Practicar con el algoritmo o diagrama de flujo de datos
;Hacer los cursos y subir en moodle, son dos


;EXAMEN
;bocina debe sonar cuando le demos click fuera del rango y cuando demos click en la opcion

