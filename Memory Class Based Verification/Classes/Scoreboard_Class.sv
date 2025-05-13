class scoreboard #(parameter WIDTH = 32 , DEPTH = 16 , ADDRESS = 4);
    transaction     trans_scr ;
    mailbox         Mon2Scr   ;
    mailbox         Seq2Scr   ;
    bit [WIDTH-1:0] in_data_buff [DEPTH-1:0]  ;

    function new(mailbox   Mon2Scr , mailbox   Seq2Scr);
        this.Mon2Scr = Mon2Scr ;
        this.Seq2Scr = Seq2Scr ;
        trans_scr = new() ;
    endfunction : new

    task receive_out ;
        forever begin     
            Mon2Scr.get(trans_scr) ;
            Seq2Scr.try_peek(in_data_buff) ;

            for(int i = 0 ; i < 32 ; i=i+1) begin
                if((in_data_buff[i] == trans_scr.out_data) && trans_scr.valid_out)
                    $display("succeful read writing  |  out_data :%h  |  Valid_out:%h" , trans_scr.out_data , trans_scr.valid_out) ;
            end
        end
    endtask : receive_out
endclass