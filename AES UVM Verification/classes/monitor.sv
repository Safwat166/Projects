class monitor extends uvm_monitor ;
    `uvm_component_utils(monitor)
    sequence_item   seq_item_inst ;
    virtual    intf    vif ;
    uvm_analysis_port #(sequence_item) mon_port ;

/*--------------------------------------------------
-- Constructor
--------------------------------------------------*/
    function new(string name = "monitor" , uvm_component parent = null) ;
        super.new(name , parent) ;
    endfunction : new

/*--------------------------------------------------
-- build phase
--------------------------------------------------*/
    function void build_phase(uvm_phase phase) ;
        super.build_phase(phase) ;
        seq_item_inst = sequence_item::type_id::create("seq_item_inst") ;
        mon_port = new("mon_port" , this) ;
        if(!uvm_config_db #(virtual intf)::get(this , "" , "my_vif" , vif)) begin
            `uvm_fatal("monitor", "Virtual interface not found in config DB!")
        end
    endfunction : build_phase

/*--------------------------------------------------
-- run phase
--------------------------------------------------*/
    task run_phase(uvm_phase phase) ;
        super.run_phase(phase) ;
        forever begin
            @(posedge vif.clk) ;
            seq_item_inst.in_data <= vif.monitor_cb.in_data ;
            seq_item_inst.key <= vif.monitor_cb.key ;
            seq_item_inst.flag <= vif.monitor_cb.flag ;
            seq_item_inst.data_out <= vif.monitor_cb.data_out ;
            //$display("in_data : %0h | out_key : %0h | flag : %0b" , vif.monitor_cb.in_data , vif.monitor_cb.key , vif.monitor_cb.flag) ;
            mon_port.write(seq_item_inst) ;
        end
    endtask : run_phase

endclass : monitor 