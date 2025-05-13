class driver extends uvm_driver #(sequence_item) ;
    `uvm_component_utils(driver)
    virtual interface intf vif ;
    sequence_item   seq_item_inst ;

/*-----------------------------------------------------------------------------
-- Constructor
-----------------------------------------------------------------------------*/
    function new(string name = "driver" , uvm_component parent = null);
        super.new(name , parent) ;
    endfunction : new

/*-----------------------------------------------------------------------------
-- Build Phase
-----------------------------------------------------------------------------*/
    function void build_phase(uvm_phase phase);
        super.build_phase(phase) ;
        if (!uvm_config_db #(virtual intf)::get(this, "", "my_vif", vif)) begin
            `uvm_fatal("Driver", "Virtual interface not found in config DB!")
        end
    endfunction : build_phase

/*-----------------------------------------------------------------------------
-- Run Phase
-----------------------------------------------------------------------------*/
    task run_phase (uvm_phase phase) ;
        super.run_phase(phase) ;
        forever begin
            seq_item_port.get_next_item(seq_item_inst) ;
            @(posedge vif.clk) ;
            vif.driver_cb.in_data <= seq_item_inst.in_data ;
            vif.driver_cb.address <= seq_item_inst.address ;
            vif.driver_cb.wr_en <= seq_item_inst.wr_en ;
            vif.driver_cb.rd_en <= seq_item_inst.rd_en ;
            seq_item_port.item_done(seq_item_inst) ;
        end

    endtask : run_phase

endclass : driver