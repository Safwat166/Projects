vlog *.sv
vopt REG_FILE_TB -o safwat +acc
vsim safwat -novopt -suppress 12110
do wave.do
run 370000