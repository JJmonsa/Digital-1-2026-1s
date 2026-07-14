//modulo de control
module control (clk, rst, start, Zero, LessA, load, SHFT, update_A, set_Q, DEC, done);
    //entradas y salidas
    input clk;
    input rst;
    input start;
    input Zero;
    input LessA;
    output reg load;
    output reg SHFT;
    output reg update_A;
    output reg set_Q;
    output reg DEC;
    output reg done;

    // estados
    parameter init = 3'b000;
    parameter Check_Counter = 3'b001;
    parameter Shift = 3'b010;
    parameter Check_minor = 3'b011;
    parameter Substract = 3'b100;
    parameter Dec_Counter = 3'b101;
    parameter Done = 3'b110;

    //registro de estado
    reg [2:0] STATE;
    reg [4:0] count;

always @(posedge clk or posedge rst) 
begin
    if (rst)begin
        STATE <= init;
    end
    else
    begin
        case (STATE)
            init:
            begin
                count<=0;
                if (start) 
                    STATE = Check_Counter;
                else
                    STATE = init;
            end
            Check_Counter:
            begin
                if (Zero)
                    STATE = Done;
                else
                    STATE = Shift;
            end
            Shift:
            begin
                STATE = Check_minor;
            end
            Check_minor:
            begin
                if (LessA)
                    STATE = Dec_Counter;
                else
                    STATE = Substract;
            end
            Substract:
            begin
                STATE = Dec_Counter;
            end
            Dec_Counter:
            begin
                STATE = Check_Counter;
            end
            Done:
            begin
                count<=count+1;
                if (count >=28) 
                    STATE = init;
                else 
                    STATE = Done;
            end

            default: STATE = init;
        endcase    
    end
end
//activacion de salidas
always @(*) 
begin
    case (STATE)
        init:
        begin
            load = 1;
            SHFT = 0;
            update_A = 0;
            set_Q = 0;
            DEC = 0;
            done = 0;
        end 
        Check_Counter:
        begin
            load = 0;
            SHFT = 0;
            update_A = 0;
            set_Q = 0;
            DEC = 0;
            done = 0;
        end 
        Shift:
        begin
            load = 0;
            SHFT = 1;
            update_A = 0;
            set_Q = 0;
            DEC = 0;
            done = 0;   
        end
        Check_minor:
        begin
            load = 0;
            SHFT = 0;
            update_A = 0;
            set_Q = 0;
            DEC = 0;
            done = 0;   
        end
        Substract:
        begin
            load = 0;
            SHFT = 0;
            update_A = 1;
            set_Q = 1;
            DEC = 0;
            done = 0; 
        end
        Dec_Counter:
        begin
            load = 0;
            SHFT = 0;
            update_A = 0;
            set_Q = 0;
            DEC = 1;
            done = 0; 
        end
        Done:
        begin
            load = 0;
            SHFT = 0;
            update_A = 0;
            set_Q = 0;
            DEC = 0;
            done = 1; 
        end
        default: 
        begin
            load = 0;
            SHFT = 0;
            update_A = 0;
            set_Q = 0;
            DEC = 0;
            done = 0; 
        end
    endcase
end

endmodule