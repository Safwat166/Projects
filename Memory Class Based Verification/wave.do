onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group DUT -color Yellow /REG_FILE_TB/DUT/in_data
add wave -noupdate -expand -group DUT -color Yellow /REG_FILE_TB/DUT/address
add wave -noupdate -expand -group DUT -color Yellow /REG_FILE_TB/DUT/wr_en
add wave -noupdate -expand -group DUT -color Yellow /REG_FILE_TB/DUT/rd_en
add wave -noupdate -expand -group DUT /REG_FILE_TB/DUT/out_data
add wave -noupdate -expand -group DUT /REG_FILE_TB/DUT/valid_out
add wave -noupdate -expand -group interface -color Cyan /REG_FILE_TB/intf1/in_data
add wave -noupdate -expand -group interface -color Cyan /REG_FILE_TB/intf1/address
add wave -noupdate -expand -group interface -color Cyan /REG_FILE_TB/intf1/wr_en
add wave -noupdate -expand -group interface -color Cyan /REG_FILE_TB/intf1/rd_en
add wave -noupdate -expand -group interface /REG_FILE_TB/intf1/out_data
add wave -noupdate -expand -group interface /REG_FILE_TB/intf1/valid_out
add wave -noupdate -expand -group interface /REG_FILE_TB/intf1/rst
add wave -noupdate -expand -group interface /REG_FILE_TB/intf1/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15001 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {14991 ps} {15026 ps}
