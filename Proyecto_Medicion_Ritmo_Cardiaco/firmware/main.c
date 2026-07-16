#include <stdint.h>

// Definición de direcciones según el mapa de memoria del SOC.v
#define PULSE_PERIOD  (*(volatile uint32_t*)0x00410004) // Ciclos entre latidos
#define WS2812_COLOR  (*(volatile uint32_t*)0x00420000) // Registro de color RGB
#define WS2812_START  (*(volatile uint32_t*)0x00420004) // Disparador (bit 0)

// Configuración: Reloj de 25MHz (definido en SOC.v)
#define CLK_FREQ 25000000

void delay(int cycles) {
    for (volatile int i = 0; i < cycles; i++);
}

void update_led(uint32_t color) {
    WS2812_COLOR = color;
    WS2812_START = 1; // Pulso para enviar datos a la matriz
}

int main() {
    uint32_t bpm = 0;
    
    while(1) {
        uint32_t period = PULSE_PERIOD;
        
        if (period > 0) {
            // BPM = (60 segundos * Frecuencia Reloj) / Periodo en ciclos
            bpm = (60 * CLK_FREQ) / period;
        }

        // Lógica de visualización simple
        if (bpm > 100) {
            update_led(0xFF0000); // Rojo si el pulso es alto
        } else if (bpm > 60) {
            update_led(0x00FF00); // Verde si es normal
        } else {
            update_led(0x0000FF); // Azul si es bajo o en espera
        }

        delay(100000); // Evitar saturación del bus
    }
    return 0;
}