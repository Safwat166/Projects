class env extends uvm_env;
    `uvm_component_utils(env)
    agent   agent_inst ;
    scoreboard  scr_inst ;
    virtual interface intf vif ;

/*-----------------------------------------------------------------------------
-- Constructor
-----------------------------------------------------------------------------*/
    function new(string name = "env" , uvm_component parent = null) ;
        super.new(name , parent) ;
    endfunction : new

/*-----------------------------------------------------------------------------
-- Build Phase 
-----------------------------------------------------------------------------*/
    function void build_phase(uvm_phase phase);
        super.build_phase(phase) ;
        agent_inst = agent::type_id::create("agent_inst" , this) ;
        scr_inst = scoreboard::type_id::create("scr_inst" , this);
        
        if (!uvm_config_db #(virtual intf)::get(this, "", "my_vif", vif)) begin
            `uvm_fatal("env", "Virtual interface not found in config DB!")
        end

        uvm_config_db #(virtual intf)::set(this , "agent_inst" , "my_vif" , vif) ;
    endfunction : build_phase

/*-----------------------------------------------------------------------------
-- Connect Phase 
-----------------------------------------------------------------------------*/
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase) ;
        agent_inst.mon_inst.monitor_port.connect(scr_inst.scr_imp) ;
    endfunction : connect_phase

endclass : env