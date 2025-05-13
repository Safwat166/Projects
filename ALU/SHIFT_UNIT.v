module SHIFT_UNIT #(parameter width = 16)
(
    input           [width-1 : 0]       a,
    input           [width-1 : 0]       b,
    input           [3:0]               alu_fun, 
    input                               clk,
    input                               rst,
    input                               shift_en,
    output  reg          [width-1 : 0]  reg_shift,
    output  reg                         reg_flag
);
    
    //internal signal
    reg          [width-1 : 0]  shift_out ;
    reg                         shift_flag ;

    //always combinational block
    always @ (*)
    begin
        shift_out = 'b0 ;
        shift_flag = 1'b0 ;
        if(shift_en)
        begin
            case(alu_fun)
            4'b1100 :begin
                shift_out = (a>>1) ;
                shift_flag = 1'b1 ;
            end
            4'b1101 :begin
                shift_out = (a<<1) ;
                shift_flag = 1'b1 ;
            end
            4'b1110 :begin
                shift_out = (b>>1) ;
                shift_flag = 1'b1 ;
            end
            4'b1111 :begin
                shift_out = (b<<1) ;
                shift_flag = 1'b1 ;
            end
            default :begin
                shift_out = 'b0 ;
                shift_flag = 1'b0 ;
            end
            endcase
        end

        else
        begin
            shift_out = 'b0 ;
            shift_flag = 1'b0 ;
        end
    end

    //sequential always block
    always @ (posedge clk , negedge rst)
    begin
        if(!rst)
        begin
            reg_shift <= 'b0 ;
            reg_flag <= 1'b0 ;
        end

        else
        begin
            reg_shift <= shift_out ;
            reg_flag <= shift_flag ;
        end
    end
endmodule