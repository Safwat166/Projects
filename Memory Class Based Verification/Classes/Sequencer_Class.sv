class sequencer #(parameter WIDTH = 32 , DEPTH = 16 , ADDRESS = 4);
    transaction trans_seq ;
    mailbox     Seq2Driv  ;
    mailbox     Seq2Scr   ;
    bit [WIDTH-1:0] in_data_buff [DEPTH-1:0]  ;
    bit [ADDRESS-1:0]   address_buff   [DEPTH-1:0] ;
/*------------------------------------------------------------------------
-- Constructor Receives Mailbox from enviroment
-- Transaction class handle
-- Note : don't make a handle for mailbox here we made it in enviroment
   so that seq and driv have same initialization for mailbox
-------------------------------------------------------------------------*/
    function new(mailbox    Seq2Driv , mailbox    Seq2Scr);
        this.trans_seq = new() ;
        this.Seq2Driv = Seq2Driv ;
        this.Seq2Scr = Seq2Scr ;
    endfunction
/*--------------------------------------------------------------------------
-- intializing values to inputs and transmit these values through mailbox
---------------------------------------------------------------------------*/
    task input_values ;

        //writing Operation
        for(int i = -1 ; i<16 ; i=i+1)  begin
                if(!trans_seq.randomize())  $display("failed to randomize values") ; // randomize input values
                
                trans_seq.wr_en = 1'b1 ;
                trans_seq.rd_en = 1'b0 ;
                trans_seq.address = i ;
                in_data_buff[i] = trans_seq.in_data ;
                address_buff[i] = trans_seq.address ;
                Seq2Driv.put(trans_seq) ;
        end
        Seq2Scr.put(in_data_buff) ;
        
        //Reading Opearation
        for(int i = 0 ; i<16 ; i = i+1) begin
                trans_seq.address = address_buff[i] ;
                trans_seq.wr_en = 1'b0  ;
                trans_seq.rd_en = 1'b1  ;
                Seq2Driv.put(trans_seq) ;
        end
    endtask
endclass