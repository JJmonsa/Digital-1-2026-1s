module control (clk, init, Zero, rst, Load, SHFT, subtract, DEC, done);
    input clk;
    input init;
    input Zero;
    input rst;
    output reg Load;
    output reg SHFT;
    output reg subtract;
    output reg DEC;
    output reg done;

parameter  START = 3'b000;
parameter  Check_counter = 3'b001;
parameter  Subtract3 = 3'b010;
parameter  Shift_dec = 3'b011;
parameter  Finish = 3'b100;

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
                counts <=0;
                if (init)
                    STATE <= Shift_dec;
                else
                    STATE <= START;
            end
            Shift_dec:
            begin
                STATE <= Check_counter;
            end
            Check_counter:
            begin
                if (Zero)
                    STATE <= Finish;
                else
                    STATE <=Subtract3;
            end
            Subtract3:
            begin
                STATE <= Shift_dec;
            end
            Finish:
            begin
                counts <=(counts+1);
                if (counts >=28)
                    STATE<= START;
                else
                    STATE <= Finish;
            end
            default:
                STATE<=START; 
        endcase
    end
end
always @(*) 
begin
    case (STATE)
        START:
        begin
            SHFT = 0;
            Load = 1;
            subtract = 0;
            DEC = 0;
            done = 0;
        end
        Check_counter:
        begin
            SHFT = 0;
            Load = 0;
            subtract = 0;
            DEC = 0;
            done = 0;
        end
        Subtract3:
        begin
            SHFT = 0;
            Load = 0;
            subtract = 1;
            DEC = 0;
            done = 0;
        end
        Shift_dec:
        begin
            SHFT = 1;
            Load = 0;
            subtract = 0;
            DEC = 1;
            done = 0;
        end
        Finish:
        begin
            SHFT = 0;
            Load = 0;
            subtract = 0;
            DEC = 0;
            done = 1;
        end
        default:
        begin
            SHFT = 0;
            Load = 0;
            subtract = 0;
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
        Shift_dec: estados="SHIFT_DEC";
        Check_counter: estados="CHECK_COUNTER";
        Subtract3: estados="SUBTRACT3";
        Finish: estados="FINISH";
        default: estados="unknown";
    endcase
end
`endif
endmodule