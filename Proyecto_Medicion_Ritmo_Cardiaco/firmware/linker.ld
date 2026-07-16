MEMORY {
    BRAM (RWX) : ORIGIN = 0x0000, LENGTH = 0x4000 /* 16KB de RAM interna */
}

SECTIONS {
    .text : {
        . = ALIGN(4);
        *(.text.entry) /* Punto de entrada definido en crt0.S */
        *(.text)
        *(.rodata*)
    } > BRAM

    .data : {
        *(.data)
    } > BRAM

    .bss : {
        *(.bss)
    } > BRAM
}