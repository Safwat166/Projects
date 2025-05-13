class sequence_item extends uvm_sequence_item ;
    `uvm_object_utils(sequence_item)

    function new (string name = "sequence_item") ;
        super.new(name) ;
    endfunction : new

    rand    bit   [31:0]  	         in_data   ;
            bit   [3:0]              address   ;
            bit                      wr_en     ;
            bit                      rd_en     ;
            bit   [31:0]             out_data  ;
            bit                      valid_out ;
endclass : sequence_item