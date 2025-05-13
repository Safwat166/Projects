module ARITHMETIC_UNIT #(parameter  width = 16)
(
    input   signed   [width-1 : 0]            a,
    input   signed   [width-1 : 0]            b,
    input                                     clk,
    input            [3:0]                    alu_fun,
    input                                     arith_en,
    input                                     rst,
    output  reg  signed    [(width*2)-1 : 0]  reg_arith ,
    output  reg                               reg_flag
);

    //internal signal
    reg  signed    [(width*2)-1 : 0]  arith_out ;
    reg                               arith_flag ;

    //combinational always block
    always @ (*)
        begin
            arith_out = 'b0 ;
            arith_flag = 1'b0 ;
            if(arith_en)
                begin
                  case(alu_fun)
                    4'b0000 : begin
                        arith_out = a + b ;
                        arith_flag = 1'b1 ;
                    end

                    4'b0001 : begin
                        arith_out = a - b ;
                        arith_flag = 1'b1 ;
                    end

                    4'b0010 : begin
                        arith_out = a * b ;
                        arith_flag = 1'b1 ;
                    end

                    4'b0011 : begin
                        arith_out = a/b ;
                        arith_flag = 1'b1 ;
                    end
                    default : begin
                        arith_out = 'b0 ; 
                        arith_flag = 1'b0 ; 
                    end
                  endcase
                end

            else
                begin
                    arith_out = 'b0 ; 
                    arith_flag = 1'b0 ;    
                end
        end
    
    //sequential always block 
    always @ (posedge clk , negedge rst)
        begin
            if(!rst)
                begin
                    reg_arith <= 'b0 ;
                    reg_flag <= 1'b0 ;
                end
            else
                begin
                    reg_arith <= arith_out ;
                    reg_flag <= arith_flag ;
                end
        end
endmodule 