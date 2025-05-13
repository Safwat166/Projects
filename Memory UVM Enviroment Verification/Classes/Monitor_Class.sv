class monitor extends uvm_monitor ;
    `uvm_component_utils(monitor)
    uvm_analysis_port #(sequence_item) monitor_port ;
    virtual interface intf vif ;
    sequence_item   seq_item_inst ;

/*-----------------------------------------------------------------------------
-- Constructor
-----------------------------------------------------------------------------*/
    function new(string name = "monitor" , uvm_component parent = null);
        super.new(name , parent) ;
    endfunction : new

/*-----------------------------------------------------------------------------
-- Build Phase
-----------------------------------------------------------------------------*/
    function void build_phase(uvm_phase phase) ;
        super.build_phase(phase) ;
        seq_item_inst = sequence_item::type_id::create("seq_item_inst");
        monitor_port = new("monitor_port" , this) ;
        if (!uvm_config_db #(virtual intf)::get(this, "", "my_vif", vif)) begin
            `uvm_fatal("monitor", "Virtual interface not found in config DB!")
        end
    endfunction : build_phase

/*-----------------------------------------------------------------------------
-- Run Phase
-----------------------------------------------------------------------------*/
    task run_phase(uvm_phase phase) ;
        super.run_phase(phase) ;
        forever begin
            @(posedge vif.clk) ;
            seq_item_inst.out_data <= vif.monitor_cb.out_data   ;
            seq_item_inst.valid_out <= vif.monitor_cb.valid_out ;
            seq_item_inst.in_data <= vif.monitor_cb.in_data ;
            seq_item_inst.address <= vif.monitor_cb.address ;
            seq_item_inst.wr_en <= vif.monitor_cb.wr_en ;
            seq_item_inst.rd_en <= vif.monitor_cb.rd_en ;
            monitor_port.write(seq_item_inst) ;
        end
    endtask : run_phase

endclass : monitor