vlog pack.sv *.*v
vopt AES_tb -o safwat +acc
vsim safwat
add wave -position insertpoint sim:/AES_tb/DUT/*
run -all