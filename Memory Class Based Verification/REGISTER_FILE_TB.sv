`timescale 1ns/1ps
module REG_FILE_TB #(parameter WIDTH = 32 , DEPTH = 16 , ADDRESS = 4);

    import pack::* ;

/*-----------------------------------------------------------------------
-- interface instance
-- enviroment instance
-- virtual interface instance
-----------------------------------------------------------------------*/
    intf               intf1() ;
    virtual    intf    vif ;
    enviroment         env ;
/*---------------------------------------------------------------------
-- DUT Instance
---------------------------------------------------------------------*/
    REGISTER_FILE DUT (
        .in_data(intf1.in_data),
        .address(intf1.address),
        .wr_en(intf1.wr_en),
        .rd_en(intf1.rd_en),
        .clk(intf1.clk),
        .rst(intf1.rst),
        .out_data(intf1.out_data),
        .valid_out(intf1.valid_out)
    );
/*--------------------------------------------------------------------
-- initial block
--------------------------------------------------------------------*/
    initial 
    begin
        intf1.clk = 0 ;
        vif = intf1 ;
        env = new(vif) ;
        env.run();
        #100 $finish() ;
    end

    always  #5  intf1.clk = ~(intf1.clk) ;
endmodule