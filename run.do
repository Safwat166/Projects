vlib work
vlog *.*v
vopt spi_tb -o safwat  +acc
vsim safwat
do wave.do
run -all