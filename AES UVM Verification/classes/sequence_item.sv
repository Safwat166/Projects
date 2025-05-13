class sequence_item extends uvm_sequence_item ;
    `uvm_object_utils(sequence_item)

/*--------------------------------------------------
-- Constructor
--------------------------------------------------*/
    function new(string name = "sequence_item");
        super.new(name) ;
    endfunction : new

/*--------------------------------------------------
-- signals
--------------------------------------------------*/
    rand    bit   [127:0]    in_data ;
    rand    bit   [127:0]    key ;
    bit                      flag ;
    bit           [127:0]    data_out ;
    
endclass : sequence_item