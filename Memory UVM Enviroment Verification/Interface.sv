interface intf #(parameter WIDTH = 32 , DEPTH = 16 , ADDRESS = 4);
    logic   [WIDTH-1:0]  	   in_data   ;
    logic   [ADDRESS-1:0]      address   ;
    logic                      wr_en     ;
    logic                      rd_en     ;
    logic   [WIDTH-1:0]        out_data  ;
    logic                      valid_out ;
    logic                      rst       ;
    logic                      clk       ;
/*--------------------------------------------------------------------
-- Driver Clocking Block to avoid racing between driver and DUT
--------------------------------------------------------------------*/
    clocking driver_cb @(posedge clk);
        default   input    #1step   output     #1step ;
        output    in_data ;
        output    address ;
        output    wr_en   ;
        output    rd_en   ;
    endclocking

/*--------------------------------------------------------------------
-- Monitor Clocking Block to avoid racing between monitor and DUT
--------------------------------------------------------------------*/
    clocking monitor_cb @(posedge clk);
        default   input    #0  output     #0 ; //to make monitor read in observe region not nba
        input    out_data  ;
        input    valid_out ;
        input    in_data ;
        input    address ;
        input    wr_en   ;
        input    rd_en   ;
    endclocking
endinterface