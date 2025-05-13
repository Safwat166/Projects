onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {TB Signals} /CLK_DIV_TB/rst_tb
add wave -noupdate -expand -group {TB Signals} -expand -group {REF CLK} -color {Dark Orchid} /CLK_DIV_TB/clk_ref_tb
add wave -noupdate -expand -group {TB Signals} -expand -group {GEN CLOCK} -color {Cornflower Blue} /CLK_DIV_TB/div_clk_tb
add wave -noupdate -expand -group {TB Signals} -expand -group {DIV RATIO} -radix unsigned /CLK_DIV_TB/div_ratio_tb
add wave -noupdate -expand -group {TB Signals} /CLK_DIV_TB/clk_en_tb
add wave -noupdate -expand -group {DUT Internal Signals} /CLK_DIV_TB/DUT/counter
add wave -noupdate -expand -group {DUT Internal Signals} /CLK_DIV_TB/DUT/flag
add wave -noupdate -expand -group {DUT Internal Signals} /CLK_DIV_TB/DUT/odd
add wave -noupdate -expand -group {DUT Internal Signals} -radix binary /CLK_DIV_TB/DUT/half_div_ratio
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {940 ps} 0}
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
WaveRestoreZoom {118 ps} {2120 ps}
