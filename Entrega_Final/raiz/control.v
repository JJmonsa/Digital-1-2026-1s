module control (clk, rst, init, Zero, Neg, load, shift, load_Temp, setRoot, Dec, update_RAC, done);
    input clk;
    input rst;
    input init;
    input Neg;
    input Zero;
    output reg load;
    output reg shift;
    output reg load_Temp;
    output reg Dec;
    output reg setRoot;
    output reg update_RAC;
    output reg done;

    //estados
    parameter Start = 3'b000;
    parameter Check_Counter = 3'b001;
    parameter Shift = 3'b010;
    parameter LoadTemp = 3'b011;
    parameter Check_RAC = 3'b100;
    parameter Update_Root = 3'b101;
    parameter Dec_Counter = 3'b110;
    parameter Done = 3'b111;

    //registro de estado
    reg [2:0] STATE;
    reg [4:0] Count;

always @(posedge clk or posedge rst) 
begin
    if (rst) 
    begin
        STATE <= Start;    
    end
    else
        begin
            case (STATE)
                Start:
                begin
                    Count<=0;
                    if (init) 
                    begin
                        STATE <= Check_Counter;
                    end
                    else 
                        STATE <= Start;
                end
                Check_Counter:
                begin
                    if (Zero) 
                    begin
                        STATE <= Done;
                    end
                    else
                        STATE <= Shift;
                end
                Shift:
                begin
                    STATE <= LoadTemp;
                end
                LoadTemp:
                begin
                    STATE <= Check_RAC;
                end
                Check_RAC:
                begin
                    if (Neg) 
                    begin
                        STATE <= Dec_Counter;    
                    end
                    else
                        STATE <= Update_Root;
                end
                Update_Root:
                begin
                    STATE <= Dec_Counter;
                end
                Dec_Counter:
                begin
                    STATE <= Check_Counter;
                end
                Done:
                begin
                    Count <= Count+1;
                    if (Count >=28) 
                    begin
                        STATE <= Start;
                    end
                    else
                        STATE <= Done;
                end

                default: STATE <= Start;
            endcase
        end
end
// activar salidas
always @(*) 
begin
    case (STATE)
        Start:
        begin
            Dec = 0;
            load = 1;
            shift = 0;
            setRoot = 0;
            load_Temp = 0;
            update_RAC = 0;
            done = 0;
        end
        Check_Counter:
        begin
            Dec = 0;
            load = 0;
            shift = 0;
            setRoot = 0;
            load_Temp = 0;
            update_RAC = 0;
            done = 0;
        end
        Shift:
        begin
            Dec = 0;
            load = 0;
            shift = 1;
            setRoot = 0;
            load_Temp = 0;
            update_RAC = 0;
            done = 0;
        end
        LoadTemp:
        begin
            Dec = 0;
            load = 0;
            shift = 0;
            setRoot = 0;
            load_Temp = 1;
            update_RAC = 0;
            done = 0;
        end
        Check_RAC:
        begin
            Dec = 0;
            load = 0;
            shift = 0;
            setRoot = 0;
            load_Temp = 0;
            update_RAC = 0;
            done = 0;
        end
        Update_Root:
        begin
            Dec = 0;
            load = 0;
            shift = 0;
            setRoot = 1;
            load_Temp = 0;
            update_RAC = 1;
            done = 0;
        end
        Dec_Counter:
        begin
            Dec = 1;
            load = 0;
            shift = 0;
            setRoot = 0;
            load_Temp = 0;
            update_RAC = 0;
            done = 0;
        end
        Done:
        begin
            Dec = 0;
            load = 0;
            shift = 0;
            setRoot = 0;
            load_Temp = 0;
            update_RAC = 0;
            done = 1;
        end
        default:
        begin
            Dec = 0;
            load = 0;
            shift = 0;
            setRoot = 0;
            load_Temp = 0;
            update_RAC = 0;
            done = 0;
        end
    endcase    
end

endmodule