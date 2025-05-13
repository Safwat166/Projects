class agent extends uvm_agent ;
    `uvm_component_utils(agent)

    driver  driv_inst ;
    sequencer   seq_inst ;
    monitor     mon_inst ;

    virtual interface intf vif ;
    
/*-----------------------------------------------------------------------------
-- Constructor
-----------------------------------------------------------------------------*/
    function new(string name = "agent" , uvm_component parent = null);
        super.new(name , parent) ;
    endfunction : new

/*-----------------------------------------------------------------------------
-- Build Phase 
-----------------------------------------------------------------------------*/
    function void build_phase(uvm_phase phase);
        super.build_phase(phase) ;
        driv_inst = driver::type_id::create("driv_inst" , this) ;
        seq_inst = sequencer::type_id::create("seq_inst" , this);
        mon_inst = monitor::type_id::create("mon_inst" , this);
        if (!uvm_config_db #(virtual intf)::get(this, "", "my_vif", vif)) begin
            `uvm_fatal("agent", "Virtual interface not found in config DB!")
        end
        uvm_config_db #(virtual intf) :: set(this , "driv_inst" , "my_vif" , vif) ;
        uvm_config_db #(virtual intf) :: set(this , "mon_inst" , "my_vif" , vif) ;
    endfunction : build_phase

/*-----------------------------------------------------------------------------
-- Connect Phase 
-----------------------------------------------------------------------------*/
    function void connect_phase (uvm_phase phase) ;
        super.connect_phase(phase) ;
        driv_inst.seq_item_port.connect(seq_inst.seq_item_export);
    endfunction : connect_phase

endclass : agent