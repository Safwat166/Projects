`timescale 1us/1ns
module  ALU_TB #(parameter width = 16) ();
    reg signed [width-1 : 0]       a_tb ;
    reg signed [width-1 : 0]       b_tb ;
    reg        [3:0]               alu_fun_tb ;
    reg                            clk_tb ;
    reg                            rst_tb ;

    wire signed [(width*2)-1 : 0]  arith_out_tb ;
    wire                           arith_flag_tb ;
    wire signed [width-1 : 0]      logic_out_tb ;
    wire                           logic_flag_tb ;
    wire            [3-1 : 0]      cmp_out_tb ;
    wire                           cmp_flag_tb ;
    wire signed [width-1 : 0]      shift_out_tb ;
    wire                           shift_flag_tb ;

    ALU_TOP     DUT
    (
        .CLK(clk_tb),
        .RST(rst_tb),
        .A(a_tb),
        .B(b_tb),
        .ALU_FUN(alu_fun_tb),
        .ARITH_OUT(arith_out_tb),
        .ARITH_FLAG(arith_flag_tb),
        .LOGIC_OUT(logic_out_tb),
        .LOGIC_FLAG(logic_flag_tb),
        .CMP_OUT(cmp_out_tb),
        .CMP_FLAG(cmp_flag_tb),
        .SHIFT_OUT(shift_out_tb),
        .SHIFT_FLAG(shift_flag_tb)
    );

    //clk generation
    always 
    begin
        #4
        clk_tb = ~clk_tb ;
        #6
        clk_tb = ~clk_tb ;
    end

    //intial block
    initial
    begin
        $dumpfile("ALU_TOP.vcd");
        $dumpvars;
        clk_tb = 1'b0 ;
        rst_tb = 1'b0 ;

        //test case 1
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0000 ;
        a_tb = -'d2 ;
        b_tb = -'d3 ;
        $display("test case 1 --Addition --neg + neg ***");
        #8
        if( (arith_out_tb != (a_tb + b_tb)) && ~arith_flag_tb )
        begin
            $display("test case 1 failed");
        end

        else
        begin
            $display("addition %0d + %0d is passed = %0d",a_tb , b_tb , arith_out_tb);
        end

        //test case 2
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0000 ;
        a_tb = 'd2 ;
        b_tb = -'d3 ;
        $display("test case 2 +- Addition +- pos + neg ***");
        #8
        if( (arith_out_tb != (a_tb + b_tb)) && ~arith_flag_tb )
        begin
            $display("test case 2 failed");
        end

        else
        begin
            $display("addition (%0d) + (%0d) is passed = (%0d)",a_tb , b_tb , arith_out_tb);
        end

        //test case 3
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0000 ;
        a_tb = -'d2 ;
        b_tb = 'd3 ;
        $display("test case 3 -+ Addition -+ neg + pos ***");
        #8
        if( (arith_out_tb != (a_tb + b_tb)) && ~arith_flag_tb )
        begin
            $display("test case 3 failed");
        end

        else
        begin
            $display("addition (%0d) + (%0d) is passed = %0d",a_tb , b_tb , arith_out_tb);
        end

        //test case 4
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0000 ;
        a_tb = 'd2 ;
        b_tb = 'd3 ;
        $display("test case 4 ++ Addition ++ pos + pos ***");
        #8
        if( (arith_out_tb != (a_tb + b_tb)) && ~arith_flag_tb )
        begin
            $display("test case 4 failed");
        end

        else
        begin
            $display("addition (%0d) + (%0d) is passed = %0d",a_tb , b_tb , arith_out_tb);
        end

        //test case 5
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0001 ;
        a_tb = -'d2 ;
        b_tb = -'d3 ;
        $display("test case 5 -- subtraction -- neg + neg ***");
        #8
        if( (arith_out_tb != (a_tb - b_tb)) && ~arith_flag_tb )
        begin
            $display("test case 5 failed");
        end

        else
        begin
            $display("subtraction (%0d) - (%0d) is passed = %0d",a_tb , b_tb , arith_out_tb);
        end

        //test case 6
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0001 ;
        a_tb = 'd2 ;
        b_tb = -'d3 ;
        $display("test case 6 +- subtraction +- pos - neg ***");
        #8
        if( (arith_out_tb != (a_tb - b_tb)) && ~arith_flag_tb )
        begin
            $display("test case 6 failed");
        end

        else
        begin
            $display("subtraction (%0d) - (%0d) is passed = %0d",a_tb , b_tb , arith_out_tb);
        end

        //test case 7
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0001 ;
        a_tb = -'d2 ;
        b_tb = 'd3 ;
        $display("test case 7 -+ subtraction -+ neg - pos ***");
        #8
        if( (arith_out_tb != (a_tb - b_tb)) && ~arith_flag_tb )
        begin
            $display("test case 7 failed");
        end

        else
        begin
            $display("subtraction (%0d) - (%0d) is passed = %0d",a_tb , b_tb , arith_out_tb);
        end

        //test case 8
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0001 ;
        a_tb = 'd2 ;
        b_tb = 'd3 ;
        $display("test case 8 ++ subtraction ++ pos - pos ***");
        #8
        if( (arith_out_tb != (a_tb - b_tb)) && ~arith_flag_tb )
        begin
            $display("test case 8 failed");
        end

        else
        begin
            $display("subtraction (%0d) - (%0d) is passed = %0d",a_tb , b_tb , arith_out_tb);
        end

        //test case 9
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0010 ;
        a_tb = -'d2 ;
        b_tb = -'d3 ;
        $display("test case 9 -- multiplication -- neg * neg ***");
        #8
        if( (arith_out_tb != (a_tb * b_tb)) && ~arith_flag_tb )
        begin
            $display("test case 9 failed");
        end

        else
        begin
            $display("multiplication (%0d) * (%0d) is passed = %0d",a_tb , b_tb , arith_out_tb);
        end

        //test case 10
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0010 ;
        a_tb = 'd2 ;
        b_tb = -'d3 ;
        $display("test case 10 +- multiplication +- pos * neg ***");
        #8
        if( (arith_out_tb != (a_tb * b_tb)) && ~arith_flag_tb )
        begin
            $display("test case 10 failed");
        end

        else
        begin
            $display("multiplication (%0d) * (%0d) is passed = %0d",a_tb , b_tb , arith_out_tb);
        end

        //test case 11
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0010 ;
        a_tb = -'d2 ;
        b_tb = 'd3 ;
        $display("test case 10 -+ multiplication -+ neg * pos ***");
        #8
        if( (arith_out_tb != (a_tb * b_tb)) && ~arith_flag_tb )
        begin
            $display("test case 11 failed");
        end

        else
        begin
            $display("multiplication (%0d) * (%0d) is passed = %0d",a_tb , b_tb , arith_out_tb);
        end

        //test case 12
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0010 ;
        a_tb = 'd2 ;
        b_tb = 'd3 ;
        $display("test case 12 ++ multiplication ++ pos * pos ***");
        #8
        if( (arith_out_tb != (a_tb * b_tb)) && ~arith_flag_tb )
        begin
            $display("test case 12 failed");
        end

        else
        begin
            $display("multiplication (%0d) * (%0d) is passed = %0d",a_tb , b_tb , arith_out_tb);
        end

        //test case 13
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0011 ;
        a_tb = -'d3 ;
        b_tb = -'d3 ;
        $display("test case 13 -- division -- neg / neg ***");
        #8
        if( (arith_out_tb != (a_tb / b_tb)) && ~arith_flag_tb )
        begin
            $display("test case 13 failed");
        end

        else
        begin
            $display("division (%0d) / (%0d) is passed = %0d",a_tb , b_tb , arith_out_tb);
        end

        //test case 14
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0011 ;
        a_tb = 'd3 ;
        b_tb = -'d3 ;
        $display("test case 14 +- division +- pos / neg ***");
        #8
        if( (arith_out_tb != (a_tb / b_tb)) && ~arith_flag_tb )
        begin
            $display("test case 15 failed");
        end

        else
        begin
            $display("division (%0d) / (%0d) is passed = %0d",a_tb , b_tb , arith_out_tb);
        end

        //test case 15
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0011 ;
        a_tb = -'d3 ;
        b_tb = 'd3 ;
        $display("test case 15 -+ division -+ neg / pos ***");
        #8
        if( (arith_out_tb != (a_tb / b_tb)) && ~arith_flag_tb )
        begin
            $display("test case 15 failed");
        end

        else
        begin
            $display("division (%0d) / (%0d) is passed = %0d",a_tb , b_tb , arith_out_tb);
        end

        //test case 16
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0011 ;
        a_tb = 'd3 ;
        b_tb = 'd3 ;
        $display("test case 16 ++ division ++ pos / pos ***");
        #8
        if( (arith_out_tb != (a_tb / b_tb)) && ~arith_flag_tb )
        begin
            $display("test case 16 failed");
        end

        else
        begin
            $display("division (%0d) / (%0d) is passed = %0d",a_tb , b_tb , arith_out_tb);
        end

        //test case 17
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0100 ;
        a_tb = 'b11 ;
        b_tb = 'b10 ;
        $display("test case 17 logic : And");
        #8
        if( (logic_out_tb != (a_tb & b_tb)) && ~logic_flag_tb )
        begin
            $display("test case 17 failed");
        end

        else
        begin
            $display("logic (%0b) & (%0b) is passed LOGIC_OUT = %0b",a_tb , b_tb , logic_out_tb);
        end

        //test case 18
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0110 ;
        a_tb = 'b11 ;
        b_tb = 'b10 ;
        $display("test case 18 logic : NAND");
        #8
        if( (logic_out_tb != ~(a_tb & b_tb)) && ~logic_flag_tb )
        begin
            $display("test case 18 failed");
        end

        else
        begin
            $display("logic ~((%0b) & (%0b)) is passed LOGIC_OUT = %0b",a_tb , b_tb , logic_out_tb);
        end

        //test case 19
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0101 ;
        a_tb = 'b11 ;
        b_tb = 'b10 ;
        $display("test case 19 logic : OR");
        #8
        if( (logic_out_tb != (a_tb | b_tb)) && ~logic_flag_tb )
        begin
            $display("test case 19 failed");
        end

        else
        begin
            $display("logic (%0b) | (%0b) is passed LOGIC_OUT = %0b",a_tb , b_tb , logic_out_tb);
        end

        //test case 20
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b0111 ;
        a_tb = 'b11 ;
        b_tb = 'b10 ;
        $display("test case 17 logic : NOR");
        #8
        if( (logic_out_tb != ~(a_tb | b_tb)) && ~logic_flag_tb )
        begin
            $display("test case 20 failed");
        end

        else
        begin
            $display("logic ~((%0b) | (%0b)) is passed LOGIC_OUT = %0b",a_tb , b_tb , logic_out_tb);
        end

        //test case 21
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b1001 ;
        a_tb = 'b11 ;
        b_tb = 'b11 ;
        $display("test case 21 comparison : A == B");
        #8
        if( (cmp_out_tb != 'd1) && ~cmp_flag_tb )
        begin
            $display("test case 21 failed");
        end

        else
        begin
            $display("comparison (%0b) == (%0b) is passed CMP_OUT = %0d",a_tb , b_tb , cmp_out_tb);
        end

        //test case 22
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b1010 ;
        a_tb = 'b11 ;
        b_tb = 'b10 ;
        $display("test case 22 comparison : A > B");
        #8
        if( (cmp_out_tb != 'd2) && cmp_flag_tb )
        begin
            $display("test case 22 failed");
        end

        else
        begin
            $display("comparison (%0b) > (%0b) is passed CMP_OUT = %0d",a_tb , b_tb , cmp_out_tb);
        end

        //test case 23
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b1011 ;
        a_tb = 'b10 ;
        b_tb = 'b11 ;
        $display("test case 22 comparison : A < B");
        #8
        if( (cmp_out_tb != 'd3) && cmp_flag_tb )
        begin
            $display("test case 23 failed");
        end

        else
        begin
            $display("comparison (%0b) < (%0b) is passed CMP_OUT = %0d",a_tb , b_tb , cmp_out_tb);
        end

        //test case 24
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b1100 ;
        a_tb = 'b11 ;
        $display("test case 24 shift : A >> 1");
        #8
        if( (shift_out_tb != (a_tb>>1)) && ~shift_flag_tb )
        begin
            $display("test case 24 failed");
        end

        else
        begin
            $display("shift : A =  (%0b) is passed SHIFT_OUT = %0b",a_tb , shift_out_tb);
        end

        //test case 25
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b1101 ;
        a_tb = 'b11 ;
        $display("test case 25 shift : A << 1");
        #8
        if( (shift_out_tb != (a_tb<<1)) && ~shift_flag_tb )
        begin
            $display("test case 25 failed");
        end

        else
        begin
            $display("shift : A =  (%0b) is passed SHIFT_OUT = %0b",a_tb , shift_out_tb);
        end

        //test case 26
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b1110 ;
        b_tb = 'b11 ;
        $display("test case 26 shift : B >> 1");
        #8
        if( (shift_out_tb != (b_tb>>1)) && ~shift_flag_tb )
        begin
            $display("test case 26 failed");
        end

        else
        begin
            $display("shift : B =  (%0b) is passed SHIFT_OUT = %0b",b_tb , shift_out_tb);
        end

        //test case 27
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b1111 ;
        b_tb = 'b1111 ;
        $display("test case 27 shift : B << 1");
        #8
        if( (shift_out_tb != (b_tb<<1)) && ~shift_flag_tb )
        begin
            $display("test case 27 failed");
        end

        else
        begin
            $display("shift : B =  (%0b) is passed SHIFT_OUT = %0b", b_tb , shift_out_tb);
        end

        //test case 28
        #2
        rst_tb = 1'b1 ;
        alu_fun_tb = 4'b1000 ;
        $display("test case 28 : NOP") ;
        #8
        if(arith_out_tb || logic_out_tb || cmp_out_tb || shift_out_tb || arith_flag_tb || logic_flag_tb || cmp_flag_tb || shift_flag_tb)
        begin
            $display("test case 28 faild");
        end
        
        else
        begin
            $display("NOP test case passed");
        end
        #10 $finish;
    end
  
endmodule