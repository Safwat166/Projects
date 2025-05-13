module LOGIC_UNIT #(parameter width = 16)
(
    input   signed  [width-1 : 0]       a,
    input   signed  [width-1 : 0]       b,
    input           [3:0]               alu_fun, 
    input                               clk,
    input                               rst,
    input                               logic_en,
    output  reg  signed  [width-1 : 0]  reg_logic,
    output  reg                         reg_flag
);

    //internal signal
    reg  signed  [width-1 : 0]  logic_out ;
    reg                         logic_flag ;

    //combinational always block
    always @ (*)
    begin
        logic_out = 'b0 ;
        logic_flag = 1'b0 ;
        if(logic_en)
        begin
            case(alu_fun)
                4'b0100 :begin
                    logic_out = a & b ;
                    logic_flag = 1'b1 ;
                end
                4'b0101 :begin
                    logic_out = a | b ;
                    logic_flag = 1'b1 ;
                end
                4'b0110 :begin
                    logic_out = ~(a & b);
                    logic_flag = 1'b1 ;
                end
                4'b0111 :begin
                    logic_out = ~(a | b);
                    logic_flag = 1'b1 ;
                end
                default :begin
                    logic_out = 'b0 ;
                    logic_flag = 1'b0 ;
                end
            endcase
        end

        else
        begin
            logic_out = 'b0 ;
            logic_flag = 1'b0 ;
        end
    end

    //sequential always block
    always @ (posedge clk , negedge rst)
    begin
        if(!rst)
        begin
            reg_logic <= 'b0 ;
            reg_flag <= 1'b0 ;
        end

        else
        begin
            reg_logic <= logic_out ;
            reg_flag <= logic_flag ;
        end
    end
endmodule