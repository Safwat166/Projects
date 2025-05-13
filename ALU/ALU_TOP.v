module ALU_TOP #(parameter width = 16)
(
    input   signed  [width-1 : 0]       A ,
    input   signed  [width-1 : 0]       B ,
    input           [3:0]               ALU_FUN ,
    input                               CLK ,
    input                               RST ,
    output  signed  [(width*2)-1 : 0]   ARITH_OUT ,
    output                              ARITH_FLAG ,
    output  signed  [width-1 : 0]       LOGIC_OUT ,
    output                              LOGIC_FLAG ,
    output  signed  [width-1 : 0]       CMP_OUT ,
    output                              CMP_FLAG ,
    output  signed  [width-1 : 0]       SHIFT_OUT ,
    output                              SHIFT_FLAG
);

    //internal signal
    wire    ARITH_ENABLE ;
    wire    LOGIC_ENABLE ;
    wire    CMP_ENABLE ;
    wire    SHIFT_ENABLE ;

    //DECODER_UNIT
    DECODER  D1 
    (.alu_func(ALU_FUN[3:2]),
     .arith_en(ARITH_ENABLE),
     .logic_en(LOGIC_ENABLE),
     .cmp_en(CMP_ENABLE),
     .shift_en(SHIFT_ENABLE)
    );

    //ARITHMETIC_UNIT
    ARITHMETIC_UNIT A1 
    (.clk(CLK),
     .rst(RST),
     .alu_fun(ALU_FUN),
     .a(A),
     .b(B),
     .arith_en(ARITH_ENABLE),
     .reg_arith(ARITH_OUT),
     .reg_flag(ARITH_FLAG)
    );

    //LOGIC_UNIT
    LOGIC_UNIT  L1
    (.clk(CLK),
     .rst(RST),
     .alu_fun(ALU_FUN),
     .a(A),
     .b(B),
     .logic_en(LOGIC_ENABLE),
     .reg_logic(LOGIC_OUT),
     .reg_flag(LOGIC_FLAG)
    );

    //COMPARE_UNIT
    CMP_UNIT #(.width_in(16) , .width_out(3))  C1  //better to parametrize it with output width = 3 to reduce hardware (less ffs)
    (.clk(CLK),
     .rst(RST),
     .alu_fun(ALU_FUN),
     .a(A),
     .b(B),
     .cmp_en(CMP_ENABLE),
     .reg_cmp(CMP_OUT),
     .reg_flag(CMP_FLAG)
    );

    //SHIFT_UNIT
    SHIFT_UNIT  S1
    (.clk(CLK),
     .rst(RST),
     .alu_fun(ALU_FUN),
     .a(A),
     .b(B),
     .shift_en(SHIFT_ENABLE),
     .reg_shift(SHIFT_OUT),
     .reg_flag(SHIFT_FLAG)
    );


endmodule