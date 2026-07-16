.section .text.entry
.globl _start

_start:
    # Inicializar el puntero de pila (Stack Pointer) al final de la BRAM
    li sp, 0x4000 
    # Saltar a la función principal en C
    call main

# Bucle infinito de seguridad
1:  j 1b