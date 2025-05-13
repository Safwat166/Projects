module DECODER
(
    input   [1:0]  alu_func , 
    output  reg    arith_en ,
    output  reg    logic_en ,
    output  reg    cmp_en ,
    output  reg    shift_en 
);

    //always block

    always @ (*)
    begin

        arith_en = 1'b0 ;
        logic_en = 1'b0 ;
        cmp_en = 1'b0 ;
        shift_en = 1'b0 ;

        case(alu_func)
            2'b00 : arith_en = 1'b1 ;
            2'b01 : logic_en = 1'b1 ;
            2'b10 : cmp_en = 1'b1 ;
            2'b11 : shift_en = 1'b1 ;
            default :begin
                arith_en = 1'b0 ;
                logic_en = 1'b0 ;
                cmp_en = 1'b0 ;
                shift_en = 1'b0 ;
            end
        endcase

    end


endmodule