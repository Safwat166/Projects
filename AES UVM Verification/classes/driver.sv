class driver extends uvm_driver #(sequence_item) ;
    `uvm_component_utils(driver)
    sequence_item   seq_item_inst ;
    virtual    intf    vif ;

/*--------------------------------------------------
-- Constructor
--------------------------------------------------*/
    function new(string name = "driver" , uvm_component parent = null) ;
        super.new(name , parent) ;
    endfunction : new

/*--------------------------------------------------
-- build phase
--------------------------------------------------*/
    function void build_phase(uvm_phase phase) ;
        super.build_phase(phase) ;
        if (!uvm_config_db #(virtual intf)::get(this, "", "my_vif", vif)) begin
            `uvm_fatal("Driver", "Virtual interface not found in config DB!")
        end
    endfunction : build_phase

/*--------------------------------------------------
-- run phase
--------------------------------------------------*/
    task run_phase(uvm_phase phase) ;
        super.run_phase(phase) ;
        forever begin
            seq_item_port.get_next_item(seq_item_inst) ;
            @(posedge vif.clk) ;
            vif.driver_cb.in_data <= seq_item_inst.in_data ;
            vif.driver_cb.key <= seq_item_inst.key ;
            vif.driver_cb.flag <= seq_item_inst.flag ;
            //$display("in_data : %0h | out_key : %0h | flag : %0b" , vif.in_data , vif.key , vif.flag) ;
            seq_item_port.item_done(seq_item_inst);
        end
    endtask : run_phase
    
endclass : driver