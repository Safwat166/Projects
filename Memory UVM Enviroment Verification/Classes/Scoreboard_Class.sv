class scoreboard extends uvm_scoreboard ;
    `uvm_component_utils(scoreboard)
    uvm_analysis_imp #(sequence_item , scoreboard) scr_imp ;
    sequence_item   collected_items [$] ;
    sequence_item   sub_item ;
    bit [31:0] in_data_arr [15:0] ;
    bit [31:0] out_data_arr [15:0] ;

/*-----------------------------------------------------------------------------
-- Constructor
-----------------------------------------------------------------------------*/
    function new(string name = "scoreboard" , uvm_component parent = null) ;
        super.new(name , parent) ;
    endfunction : new

/*-----------------------------------------------------------------------------
-- Build Phase 
-----------------------------------------------------------------------------*/
    function void build_phase(uvm_phase phase) ;
        super.build_phase(phase) ;
        scr_imp = new("scr_imp" , this) ;
    endfunction : build_phase

/*-----------------------------------------------------------------------------
-- write task 
-----------------------------------------------------------------------------*/
    virtual  task  write(sequence_item   seq_item_inst) ;
        if(seq_item_inst.wr_en != seq_item_inst.rd_en) begin
            collected_items.push_front(seq_item_inst) ;
        end
    endtask : write

/*-----------------------------------------------------------------------------
-- run phase 
-----------------------------------------------------------------------------*/
    task run_phase(uvm_phase phase);
        super.run_phase(phase) ;

        //extract output data and input data from the 32 transactions
        for(int i = 0 ; i < 32 ; i=i+1) begin
            wait(collected_items.size > 0);     //to avoid racing between write task and run_phase task
            sub_item = collected_items.pop_back() ;

            if(!(sub_item.valid_out))  begin
                in_data_arr[sub_item.address] = sub_item.in_data ;
            end

            else  begin
                out_data_arr[sub_item.address] = sub_item.out_data ;
            end
        end

        //compare data of two arrays (input data array and output data array)
        for(int i = 0 ; i < 16 ; i=i+1) begin
            for(int j = 0 ; j < 16 ; j=j+1) begin
                if(in_data_arr[i] == out_data_arr[j])   begin
                    $display(">-----------------------------------------------<");
                    $display("    successful read and write data transaction") ;
                    $display("           extracted data : %0h" , in_data_arr[i]) ;
                end
            end
        end

    endtask : run_phase

endclass : scoreboard