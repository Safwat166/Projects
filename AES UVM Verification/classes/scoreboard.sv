class scoreboard extends uvm_scoreboard ;
    `uvm_component_utils(scoreboard)
    uvm_analysis_imp #(sequence_item , scoreboard) scr_imp ;
    bit     [127:0]     exp_out ;
    bit     [127:0]     exp_out_arr    [9:0] ;
    bit     [127:0]     cal_out_arr    [9:0] ;
    int     i ;
    event   write_run ; //sync between write task and run phase task 
    int     fd ;

/*--------------------------------------------------
-- Constructor
--------------------------------------------------*/
    function new(string name = "scoreboard" , uvm_component parent = null);
        super.new(name , parent) ;
    endfunction : new

/*--------------------------------------------------
-- build phase
--------------------------------------------------*/
    function void build_phase(uvm_phase phase) ;
        super.build_phase(phase) ;
        scr_imp =  new("scr_imp" , this) ;
    endfunction : build_phase

/*--------------------------------------------------
-- write task
--------------------------------------------------*/

//note : i made some modification on the write task
    task write (sequence_item t);
        if(((t.in_data && t.key) != 'h0) && (i < 10)) begin   // to filter any wrong sampled data by the monitor

            // NOTE: MAKE SURE THE PATH TO CODE AND FILES ARE RIGHT 
            // TIP : RUN THE PYTHON CODE ON TERMINAL FROM THE DIRECTORY 
            //       OF THE UVM SCOREBOARD TO CHECK NO ERRORS

            // Open file "key.txt" for writing
            string python_path = "D:\\Digital Design Verfication\\Week 8\\AES\\Python_code\\";
            fd = $fopen({python_path, "key.txt"}, "w");

            // Write key.txt
            $fdisplay(fd, "%h\n%h", t.in_data, t.key);
            $fclose(fd);
            
            // Execute Python + redirect errors (Windows style)
            $system($sformatf("python \"%saes_enc.py\" > \"%spython_output.log\" 2>&1", python_path, python_path));
            
            // Read output.txt
            fd = $fopen({python_path, "output.txt"}, "r");
            $fscanf(fd, "%h", exp_out) ;

            $fclose(fd);

            // STORE ACTUAL OUTPUT AND EXPECTED OUTPUT
            exp_out_arr[i] = exp_out ;
            cal_out_arr[i] = t.data_out ;
            i = i+1 ;
            
            if(i == 10) begin
                -> write_run ;
            end
        end
    endtask : write

/*--------------------------------------------------
-- run phase
--------------------------------------------------*/
    task run_phase(uvm_phase phase) ;
        super.run_phase(phase) ;
        @(write_run) ;

        //comparing mechanism
        $display(">--------------------------------------------------------------------------------------<") ;
        for(int j = 0 ; j<10 ; j=j+1) begin
            for(int k = 0 ; k<10 ; k=k+1) begin
                if(exp_out_arr[j] == cal_out_arr[k]) begin
                    $display("successful encryption process | encrypted data : %0h" , exp_out_arr[j]) ;
                end
            end
            $display(">--------------------------------------------------------------------------------------<") ;
        end

    endtask : run_phase

endclass : scoreboard