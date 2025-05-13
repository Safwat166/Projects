module REGISTER_FILE #(parameter WIDTH = 32 , DEPTH = 16 , ADDRESS = 4)
(
input   wire    [WIDTH-1:0]  	  in_data  ,
input   wire    [ADDRESS-1:0]   address  ,
input   wire            		    wr_en    ,
input   wire            		    rd_en    ,
input   wire            		    clk      ,
input   wire            		    rst      ,

output  reg     [WIDTH-1:0]  	  out_data ,
output	reg						          valid_out 
);

/*----------------------------------------------------------------------
-- for loop parameter
----------------------------------------------------------------------*/
integer I ;
	
/*----------------------------------------------------------------------
-- 2D Array
----------------------------------------------------------------------*/
reg [WIDTH-1:0] memory [DEPTH-1:0] ;


/*----------------------------------------------------------------------
-- Sequential always block
----------------------------------------------------------------------*/
always @ (posedge clk or negedge rst)
  begin
    if(!rst)
    begin
      for(I = 0 ; I < DEPTH ; I = I + 1 )
			begin
				memory[I] <= 'b0 ;
			end
      out_data <= 'b0  ;
			valid_out <= 1'b0 ;
    end

    else
    begin
      case( {rd_en , wr_en} ) 
        2'b01 :	begin
					memory[address] <= in_data ;
					valid_out <= 1'b0 ;
				end
        2'b10 : begin
					out_data <= memory[address] ;
					valid_out <= 1'b1 ;
				end
      endcase
    end
  end
endmodule