class my_sequence extends uvm_sequence ;
    `uvm_object_utils(my_sequence)

    sequence_item   seq_item_inst ;

/*-----------------------------------------------------------------------------
-- Constructor
-----------------------------------------------------------------------------*/
    function new(string name = "my_sequence") ;
        super.new(name) ;
    endfunction : new

/*-----------------------------------------------------------------------------
-- pre_body
-----------------------------------------------------------------------------*/
    task pre_body ;
        seq_item_inst = sequence_item::type_id::create("seq_item_inst") ;
        set_response_queue_depth(33);
    endtask : pre_body
    
/*-----------------------------------------------------------------------------
-- body
-----------------------------------------------------------------------------*/
    task body ;
        //writing Operation
        for(int i = 0 ; i<16 ; i=i+1)  begin
            start_item(seq_item_inst) ;
            if(!seq_item_inst.randomize())  $display("failed to randomize values") ; // randomize input data 
            seq_item_inst.wr_en = 1'b1 ;
            seq_item_inst.rd_en = 1'b0 ;
            seq_item_inst.address = i ;
            finish_item(seq_item_inst) ;
        end

        //Reading Opearation
        for(int i = 0 ; i<17 ; i = i+1) begin
            start_item(seq_item_inst) ;
            seq_item_inst.wr_en = 1'b0  ;
            seq_item_inst.rd_en = 1'b1  ;
            seq_item_inst.address = i ;
            finish_item(seq_item_inst) ;
        end
    endtask : body
endclass : my_sequence