module aes_wrapper (
    input   wire   [127:0]    in_data  ,
    input   wire   [127:0]    key      ,
    input   wire              flag     ,
    input   wire              clk      ,
    output  logic  [127:0]    data_out    
) ;
    logic   [127:0]   encrypted_out , decrypted_out ;

    AES_Encrypt e1 (in_data,key,encrypted_out) ;
    AES_Decrypt d1 (in_data,key,decrypted_out);

    //choose which output between decrypt and encrypt output
    always @ (posedge clk)  begin
        if(flag) begin
            data_out <= encrypted_out ;
        end

        else begin
            data_out <= decrypted_out ;
        end
    end
    
endmodule : aes_wrapper