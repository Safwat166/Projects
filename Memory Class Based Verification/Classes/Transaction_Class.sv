class transaction #(parameter WIDTH = 32 , DEPTH = 16 , ADDRESS = 4) ;
    rand    bit   [WIDTH-1:0]  	     in_data   ;
            bit   [ADDRESS-1:0]      address   ;
            bit                      wr_en     ;
            bit                      rd_en     ;
            bit   [WIDTH-1:0]        out_data  ;
            bit                      valid_out ;
endclass