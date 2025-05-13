class enviroment;
    sequencer           seq      ;
    driver              driv     ;
    monitor             mon      ;
    scoreboard          scr      ;
    mailbox             Seq2Driv ;
    mailbox             Mon2Scr  ;
    mailbox             Seq2Scr  ;

    function new(virtual    intf    vif);
        Seq2Driv = new(1) ;   //set size of mailbox by 1 to synchronize between Seq & Driv (.put() will block untill we .get() from mailbox)
        Mon2Scr = new(1)  ;
        Seq2Scr = new()  ;
        seq = new(Seq2Driv , Seq2Scr) ;
        driv = new(Seq2Driv , vif) ;
        mon  = new(Mon2Scr , vif)  ;
        scr  = new(Mon2Scr , Seq2Scr) ;
    endfunction : new

    task run() ;

        driv.reset();
        fork
            seq.input_values()  ;
            driv.receive_data() ;
            mon.sample_out()    ;
            scr.receive_out()   ;
        join

    endtask : run
endclass : enviroment