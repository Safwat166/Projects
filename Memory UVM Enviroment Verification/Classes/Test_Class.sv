class test extends uvm_test ;
    `uvm_component_utils(test) ;
    env env_inst ;
    my_sequence seq_inst ;
    virtual interface intf vif ;

/*-----------------------------------------------------------------------------
-- Constructor
-----------------------------------------------------------------------------*/
    function new(string name = "test" , uvm_component parent = null) ;
        super.new(name , parent) ;
    endfunction : new

/*-----------------------------------------------------------------------------
-- Build Phase 
-----------------------------------------------------------------------------*/
    function void build_phase(uvm_phase phase);
        super.build_phase(phase) ;
        env_inst = env::type_id::create("env_inst" , this) ;
        seq_inst = my_sequence::type_id::create("seq_inst" , this) ;

        if (!uvm_config_db #(virtual intf)::get(this, "", "my_vif", vif)) begin
            `uvm_fatal("TEST", "Virtual interface not found in config DB!")
        end

        uvm_config_db #(virtual intf)::set(this , "env_inst" , "my_vif" , vif) ;
    endfunction : build_phase

/*-----------------------------------------------------------------------------
-- Run Phase
-----------------------------------------------------------------------------*/
    task run_phase(uvm_phase phase);
        super.run_phase(phase) ;
        phase.raise_objection(this) ;
        seq_inst.start(env_inst.agent_inst.seq_inst) ;
        #20ns ;
        phase.drop_objection(this) ;
    endtask : run_phase

endclass : test