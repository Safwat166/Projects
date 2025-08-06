onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /spi_tb/clk_tb
add wave -noupdate /spi_tb/rst_n_tb
add wave -noupdate -expand -group {seriel input} -color {Blue Violet} /spi_tb/MOSI_tb
add wave -noupdate -expand -group {start and end communication} -color Yellow /spi_tb/SS_n_tb
add wave -noupdate -expand -group {seriel output} -color Cyan /spi_tb/MISO_tb
add wave -noupdate -expand -group {internal signals} -color Orange -radix binary /spi_tb/DUT/rx_data
add wave -noupdate -expand -group {internal signals} -color Orange /spi_tb/DUT/rx_valid
add wave -noupdate -expand -group {internal signals} -color Orange -radix binary /spi_tb/DUT/tx_data
add wave -noupdate -expand -group {internal signals} -color Orange /spi_tb/DUT/tx_valid
add wave -noupdate -radix binary /spi_tb/DUT/f1/current_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {200 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {662 ns}
