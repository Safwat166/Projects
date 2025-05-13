class driver ;
    virtual    intf    vif ;
    mailbox            Seq2Driv   ;
    transaction        trans_driv ;
/*------------------------------------------------------------------------
-- Constructor Receives Mailbox & virtual interface from enviroment
-- Note : we don't make handle for the mailbox here because if i made 
   handle here it will intialze the mailbox and the mailbox will be empty
   and .get will be blocked all the time
-------------------------------------------------------------------------*/
    function new(mailbox  Seq2Driv , virtual  intf  vif);
        this.Seq2Driv = Seq2Driv ;
        this.vif = vif ;
        this.trans_driv = new();
    endfunction : new
/*----------------------------------------------------------------------
-- Receving all data in transaction class and put this data on 
   virtual interface
-- Note : get() is blocking(it waits untill the mailbox contains content)
   so we can use (delay or event or ..edge clk or set size of mailbox by 1)
   in the driver to synchronize between sequencer and driver
-- i used forever loop so i can receive more than one packet
----------------------------------------------------------------------*/
    task receive_data;
        forever begin
            //Seq2Driv.get(trans_driv) ;
            @(posedge vif.clk) ;
            Seq2Driv.get(trans_driv) ;
            vif.driver_cb.in_data <= trans_driv.in_data ;
            vif.driver_cb.address <= trans_driv.address ;
            vif.driver_cb.wr_en <= trans_driv.wr_en ;
            vif.driver_cb.rd_en <= trans_driv.rd_en ;
        end
    endtask : receive_data
/*--------------------------------------------------------------------------
-- Reset Task
---------------------------------------------------------------------------*/
    task reset;
        $display("----------------> Reset <-------------------");
        @(posedge vif.clk)
        vif.rst <= 1'b0 ;
        @(posedge vif.clk)
        vif.rst <= 1'b1 ;
        $display("out data : %b",vif.out_data);
        $display("valid out : %b",vif.valid_out);
        $display("reset at time %0t",$time);
        $display("------------> Reset Ended <-----------------");
    endtask : reset
endclass