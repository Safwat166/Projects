`timescale 1ns/1ps
module  AES_tb ;
    import uvm_pkg::* ;
    import pack::* ;

/*--------------------------------------------------
-- interface instance
--------------------------------------------------*/
    intf    intf1() ;

/*--------------------------------------------------
-- module instance
--------------------------------------------------*/
    aes_wrapper DUT (
        .in_data(intf1.in_data) ,
        .key(intf1.key) ,
        .flag(intf1.flag) ,
        .data_out(intf1.data_out),
        .clk(intf1.clk)
    ) ;

/*--------------------------------------------------
-- initial block
--------------------------------------------------*/
    initial begin
        intf1.clk = 0 ;
        uvm_config_db #(virtual intf) :: set(null , "uvm_test_top" , "my_vif" , intf1) ;
        run_test("test") ;
    end

/*--------------------------------------------------
-- clock generation
--------------------------------------------------*/
    always  #5  intf1.clk = ~(intf1.clk) ;

endmodule : AES_tb