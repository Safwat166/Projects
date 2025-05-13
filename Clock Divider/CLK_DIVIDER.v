module CLK_DIV #(parameter width = 8)(

	input	wire				clk_ref   ,
	input	wire				rst       ,
	input	wire				i_clk_en  ,
	input 	wire [width-1 : 0]	div_ratio ,
	
	output	reg					o_div_clk
);
	reg	  [width-2 : 0]	counter        ;
	reg					flag           ;
	wire				odd            ;
	wire  [width-2 : 0] half_div_ratio ;
	reg					div_clk        ;
	wire				clk_en         ;
	
	//sequential always block
	always @ (posedge clk_ref or negedge rst)
	begin	
	
		if(!rst)
		begin
			div_clk <= 1'b0 ;
			counter <= 'b0    ;
			flag    <= 1'b1   ;
		end
		
		else if (clk_en)
		begin
		
			//even condition
			if(!odd && counter == (half_div_ratio))
			begin
				div_clk <= ~div_clk ;
				counter <= 8'b0     ;
			end
		
			//odd condition
			else if ( ( odd && (counter == (half_div_ratio)) && flag ) || ( odd && (counter == ((half_div_ratio)+1'b1)) && !flag ) )
			begin
				div_clk <= ~div_clk ;
				counter <= 'b0      ;
				flag <= ~flag       ;
			end
						
			else
			begin
				counter <= counter + 1'b1 ;
			end
		end
		
		else 
		begin
			div_clk <= 1'b0   ;
			counter <= 'b0    ;
		end	
	end
	
	assign  half_div_ratio = (div_ratio >> 1'b1) - 1'b1 ;
	assign 	odd = div_ratio[0] ; 
	assign clk_en = i_clk_en && (div_ratio != 0) && (div_ratio != 1) ;
	
	//combinational always block (mux)
	always @ (*)
	begin
		if(clk_en)
		begin
			o_div_clk = div_clk ;
		end
		
		else
		begin
			o_div_clk = clk_ref ;
		end
	end
endmodule
