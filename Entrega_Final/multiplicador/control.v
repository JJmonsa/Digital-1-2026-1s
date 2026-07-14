module control (clk, rst, init, LSB, Zero, ADD, load, Shft_Dec, done);
input clk;
input rst;
input init;
input LSB;
input Zero;
output reg ADD;
output reg load;
output reg Shft_Dec;
output reg done;

//estados

parameter  Start = 3'b000;
parameter  Check_Counter = 3'b001;
parameter  Check_LSB = 3'b010;
parameter  Add = 3'b011;
parameter  Shift = 3'b100;
parameter  Show_Result = 3'b101;

reg [2:0] STATE;
reg [4:0] count;


always @(posedge clk or posedge rst) 
begin
    if (rst)begin
        STATE <= Start;
    end
    else 
    begin
    case(STATE)
        Start:
        begin
            count<=0;
            if(init)
                STATE = Check_Counter;
            else 
                STATE = Start;
        end
        Check_Counter:
        begin
            if(Zero)
                STATE=Show_Result;
            else
                STATE=Check_LSB;
        end
        Check_LSB:
        begin
            if(LSB)
                STATE=Add;
            else
                STATE=Shift; 
        end
        Add:
        begin
            STATE=Shift;
        end
        Shift:
        begin
            STATE=Check_Counter;
        end
        Show_Result:
        begin
           count <= count + 1;
            if (count >= 28)
                STATE=Start;
            else 
                STATE = Show_Result;
        end
        default:
            STATE=Start; 
    endcase
    end
end
always @(*) 
begin
   case (STATE)
    Start:
    begin
        load=1;
        ADD=0;
        Shft_Dec=0;
        done=0;
    end
    Check_Counter:
    begin
        done=0;
        load=0;
        ADD=0;
        Shft_Dec=0;
    end
    Check_LSB:
    begin
        done=0;
        load=0;
        ADD=0;
        Shft_Dec=0;
    end
    Add:
    begin
        ADD=1;
        load=0;
        Shft_Dec=0;
        done=0;
    end
    Shift:
    begin
        Shft_Dec=1;
        load=0;
        ADD=0;
        done=0;
    end
    Show_Result:
    begin
        done=1;
        load=0;
        ADD=0;
        Shft_Dec=0;
    end

    default:
    begin
        done=0;
        load=0;
        ADD=0;
        Shft_Dec=0;
    end


   endcase 
end
    
endmodule