class monitor ;

    virtual    intf    vif       ;
    mailbox            Mon2Scr   ;
    transaction        trans_mon ;

    function new(mailbox  Mon2Scr , virtual     intf    vif);
        trans_mon = new() ;
        this.Mon2Scr = Mon2Scr ;
        this.vif = vif ;
    endfunction : new

    task sample_out ;
        forever begin
            @(posedge vif.clk) ;
            trans_mon.out_data <= vif.monitor_cb.out_data   ;
            trans_mon.valid_out <= vif.monitor_cb.valid_out ;
            Mon2Scr.put(trans_mon) ;
        end
    endtask : sample_out

endclass : monitor