module bram (
    input clk,
    input [31:0] mem_addr,
    input [31:0] mem_wdata,
    input [3:0]  mem_wmask,
    input        mem_rstrb,
    output reg [31:0] mem_rdata
);
    // Definición de 16KB de memoria (4096 palabras de 32 bits)
    reg [31:0] mem [0:4095];

    // Carga inicial del firmware (el archivo debe estar en la misma carpeta)
    initial begin
        $readmemh("firmware.hex", mem);
    end

    // Operación de Escritura con Máscara (Byte-addressable)
    always @(posedge clk) begin
        if (mem_wmask) mem[mem_addr[13:2]][7:0]   <= mem_wdata[7:0];
        if (mem_wmask[5]) mem[mem_addr[13:2]][15:8]  <= mem_wdata[15:8];
        if (mem_wmask[6]) mem[mem_addr[13:2]][23:16] <= mem_wdata[23:16];
        if (mem_wmask[7]) mem[mem_addr[13:2]][31:24] <= mem_wdata[31:24];
    end

    // Operación de Lectura
    always @(posedge clk) begin
        if (mem_rstrb)
            mem_rdata <= mem[mem_addr[13:2]];
    end
endmodule