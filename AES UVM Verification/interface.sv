interface   intf ;
    logic   [127:0]    in_data ;
    logic   [127:0]    key ;
    logic              flag ;
    logic   [127:0]    data_out ;
    logic              clk ;

/*--------------------------------------------------------------------
-- Driver Clocking Block to avoid racing between driver and DUT
--------------------------------------------------------------------*/
    clocking driver_cb @(posedge clk) ;
        default   input    #1step   output     #1step ;
        output in_data ;
        output key ;
        output flag ;
    endclocking : driver_cb

/*--------------------------------------------------------------------
-- Monitor Clocking Block to avoid racing between monitor and DUT
--------------------------------------------------------------------*/
    clocking monitor_cb @(posedge clk) ;
        default   input    #0  output     #0 ; //to make monitor read in observe region not nba
        input data_out ;
        input in_data ;
        input key ;
        input flag ;
    endclocking : monitor_cb

endinterface : intf