class test extends uvm_test ;
    `uvm_component_utils(test)
    env env_inst ;
    my_sequence packet ; 
    virtual intf vif ;

/*--------------------------------------------------
-- Constructor
--------------------------------------------------*/
    function new(string name = "test" , uvm_component parent = null);
        super.new(name , parent) ;
    endfunction : new

/*--------------------------------------------------
-- build phase
--------------------------------------------------*/
    function void build_phase(uvm_phase phase) ;
        super.build_phase(phase) ;
        env_inst = env::type_id::create("env_inst" , this) ;
        packet = my_sequence::type_id::create("packet") ;
        if(!uvm_config_db #(virtual intf)::get(this , "" , "my_vif" , vif)) begin
            `uvm_fatal("test", "Virtual interface not found in config DB!")
        end
        uvm_config_db #(virtual intf)::set(this , "env_inst" , "my_vif" , vif) ;
    endfunction : build_phase

/*--------------------------------------------------
-- run phase
--------------------------------------------------*/
    task run_phase(uvm_phase phase) ;
        super.run_phase(phase) ;
        phase.raise_objection(this) ;
        packet.start(env_inst.agent_inst.seq_inst) ;
        #30ns ;
        phase.drop_objection(this) ;
    endtask : run_phase

endclass : test 