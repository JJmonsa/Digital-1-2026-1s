module control (clk, rst, init, Zero, LSB, Load, SHFT, DEC, INC, done);
input clk;
input rst;
input init;
input Zero;
input LSB;
output reg Load;
output reg SHFT;
output reg DEC;
output reg INC;
output reg done;

parameter Start = 3'b000;
parameter Check_counter = 3'b001;
parameter Check_lsb = 3'b010;
parameter inc_reg = 3'b011;
parameter shift_dec = 3'b100;
parameter Finish = 3'b101;

reg [2:0] STATE;
reg [4:0] Count;

always @(posedge clk or posedge rst) 
begin
    if (rst)
        STATE <= Start;
    else begin
        case (STATE)
            Start:
            begin
                Count <= 0;
                if(init)
                    STATE <= Check_counter;
                else
                    STATE <= Start; 
            end 
            Check_counter:
            begin
                if(Zero)
                    STATE <= Finish;
                else
                    STATE <= Check_lsb; 
            end
            Check_lsb:
            begin
                if(LSB)
                    STATE <= inc_reg;
                else
                    STATE <= shift_dec;  
            end
            inc_reg:
            begin
                STATE <= shift_dec;
            end
            shift_dec:
            begin
                STATE <= Check_counter;
            end
            Finish:
            begin
                Count <= Count+1;
                if (Count >= 28) 
                    STATE <= Start;
                else
                    STATE <= Finish;
            end
            default:
                STATE <= Start;
        endcase
    end 
end
always @(*) 
begin
    case (STATE)
        Start:
        begin
            SHFT=0;
            Load=1;
            DEC=0;
            INC=0;
            done=0;
        end
        Check_counter:
        begin
            SHFT=0;
            Load=0;
            DEC=0;
            INC=0;
            done=0;
        end
        Check_lsb:
        begin
            SHFT=0;
            Load=0;
            DEC=0;
            INC=0;
            done=0;
        end
        inc_reg:
        begin
            SHFT=0;
            Load=0;
            DEC=0;
            INC=1;
            done=0;
        end
        shift_dec:
        begin
            SHFT=1;
            Load=0;
            DEC=1;
            INC=0;
            done=0;
        end
        Finish:
        begin
            SHFT=0;
            Load=0;
            DEC=0;
            INC=0;
            done=1;
        end
        default:
        begin
            SHFT=0;
            Load=0;
            DEC=0;
            INC=0;
            done=0;
        end
    endcase    
end
`ifdef BENCH
reg [8*20:1] estados;
always @(*) begin
    case (STATE)
        Start: estados="START";
        Check_lsb: estados="CHECK_LSB";
        Check_counter: estados="CHECK_COUNTER";
        inc_reg: estados="INC_REG";
        shift_dec: estados="SHIFT_DEC";
        Finish: estados="FINISH";
        default: estados="unknown";
    endcase
end
`endif
endmodule