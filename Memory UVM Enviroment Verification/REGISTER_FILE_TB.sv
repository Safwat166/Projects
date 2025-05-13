`timescale 1ns/1ps
module REG_FILE_TB;
    import uvm_pkg::* ;
    import pack::* ;

/*-----------------------------------------------------------------------
-- interface instance
-----------------------------------------------------------------------*/
    intf    intf1() ;

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
        uvm_config_db #(virtual  interface  intf) :: set(null , "uvm_test_top" , "my_vif" , intf1) ;
        run_test("test");
    end

/*--------------------------------------------------------------------
-- Clock Generation
--------------------------------------------------------------------*/
    always  #5  intf1.clk = ~(intf1.clk) ;

endmodule