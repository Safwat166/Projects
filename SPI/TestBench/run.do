vlib work
vlog ../RTL_SPI/*.*v   spi_tb.sv
vopt spi_tb -o safwat  +acc
vsim safwat
do wave.do
run -all