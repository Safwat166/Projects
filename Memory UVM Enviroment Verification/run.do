vlog *.sv
vopt REG_FILE_TB -o safwat +acc
vsim safwat
add wave -position insertpoint sim:/REG_FILE_TB/intf1/*
run -all