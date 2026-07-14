module control (clk, rst, init, Zero, Load, SHFT, add, DEC, done);
input clk;
input rst;
input init;
input Zero;
output reg Load;
output reg SHFT;
output reg add;
output reg DEC;
output reg done;

parameter START = 3'b000;
parameter SHIFT_DEC = 3'b001;
parameter CHECK_COUNTER = 3'b010;
parameter ENABLE_SUM = 3'b011;
parameter FINISH = 3'b100;
reg [2:0] STATE;
reg [5:0] counts;

always @(posedge clk or posedge rst) 
begin
    if (rst) 
    begin
        STATE <= START;    
    end
    else begin
        case (STATE)
            START:
            begin
                counts <= 0;
                if (init) 
                begin
                    STATE <= SHIFT_DEC;    
                end
                else
                    STATE <= START;
            end
            SHIFT_DEC:
            begin
                STATE <= CHECK_COUNTER;
            end
            CHECK_COUNTER:
            begin
                if (Zero) 
                begin
                    STATE <= FINISH;    
                end
                else
                    STATE <= ENABLE_SUM;
            end
            ENABLE_SUM:
            begin
                STATE <= SHIFT_DEC;
            end
            FINISH:
            begin
                counts <= counts + 1;
                if (counts >= 28) 
                begin
                    STATE <= START;    
                end
                else
                    STATE <= FINISH;

            end
            default:
                STATE <= START;
        endcase
    end
end
always @(*) 
begin
    case (STATE)
        START:
        begin
            Load = 1;
            SHFT = 0;
            add = 0;
            DEC = 0;
            done = 0; 
        end
        SHIFT_DEC:
        begin
            Load = 0;
            SHFT = 1;
            add = 0;
            DEC = 1;
            done = 0; 
        end
        CHECK_COUNTER:
        begin
            Load = 0;
            SHFT = 0;
            add = 0;
            DEC = 0;
            done = 0;       
        end
        ENABLE_SUM:
        begin
            Load = 0;
            SHFT = 0;
            add = 1;
            DEC = 0;
            done = 0;    
        end
        FINISH:
        begin
            Load = 0;
            SHFT = 0;
            add = 0;
            DEC = 0;
            done = 1;              
        end
        default:
        begin
            Load = 0;
            SHFT = 0;
            add = 0;
            DEC = 0;
            done = 0;     
        end
    endcase
    
end
`ifdef BENCH
reg [8*20:1] estados;
always @(*) begin
    case (STATE)
        START: estados="START";
        SHIFT_DEC: estados="SHIFT_DEC";
        CHECK_COUNTER: estados="CHECK_COUNTER";
        ENABLE_SUM: estados="ENABLE_SUM";
        FINISH: estados="FINISH";
        default: estados="unknown";
    endcase
end
`endif
endmodule