class my_sequence extends uvm_sequence ;
    `uvm_object_utils(my_sequence)
    sequence_item   seq_item_inst ;

/*--------------------------------------------------
-- Constructor
--------------------------------------------------*/
    function new(string name = "my_sequence");
        super.new(name) ;
    endfunction : new

/*--------------------------------------------------
-- pre_body
--------------------------------------------------*/
    task pre_body;
        seq_item_inst = sequence_item::type_id::create("seq_item_inst") ;
        set_response_queue_depth(11);
    endtask : pre_body

/*--------------------------------------------------
-- body
--------------------------------------------------*/
    task body ;

        //encryption operation
        for(int i = 0 ; i<10 ; i=i+1) begin
            start_item(seq_item_inst) ;
            if( !seq_item_inst.randomize() ) $fatal("Gen:: trans randomization failed");
            seq_item_inst.flag = 1'b1 ;
            finish_item(seq_item_inst) ;
        end

    endtask : body
    
endclass : my_sequence