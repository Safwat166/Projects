module CMP_UNIT #(parameter width_in = 16 , width_out = 16)
(
    input     [width_in-1 : 0]       a,
    input     [width_in-1 : 0]       b,
    input           [3:0]               alu_fun, 
    input                               clk,
    input                               rst,
    input                               cmp_en,
    output  reg   [width_out-1 : 0]  reg_cmp,
    output  reg                         reg_flag
);

    //internal signal
    reg    [width_out-1 : 0]  cmp_out ;
    reg                         cmp_flag ;

    //combinational always block
    always @ (*)
    begin
        cmp_out = 'b0 ;
        cmp_flag = 1'b0 ;
        if(cmp_en)
        begin
            case(alu_fun)
            4'b1001 :begin
                cmp_out = (a==b) ? 'd1 : 'd0 ;
                cmp_flag = 1'b1 ;
            end
            4'b1010 :begin
                cmp_out = (a>b) ? 'd2 : 'd0 ;
                cmp_flag = 1'b1 ;
            end
            4'b1011 :begin
                cmp_out = (a<b) ? 'd3 : 'd0 ;
                cmp_flag = 1'b1 ;           
            end
            default :begin
                cmp_out = 'b0 ;
                cmp_flag = 1'b0 ;
            end
            endcase
        end

        else
        begin
            cmp_out = 'b0 ;
            cmp_flag = 1'b0 ;
        end
    end

    //sequential always block 
    always @ (posedge clk , negedge rst)
    begin
        if(!rst)
        begin
            reg_cmp <= 'b0 ;
            reg_flag <= 1'b0 ;
        end

        else
        begin
            reg_cmp <= cmp_out ;
            reg_flag <= cmp_flag ; 
        end
    end
endmodule