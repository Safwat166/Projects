vlib work
vlog *.*v
vsim -voptargs=+acc work.CLK_DIV_TB
do wave.do
run -all