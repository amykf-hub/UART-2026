onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tx_modul_tb/clk
add wave -noupdate /tx_modul_tb/rst
add wave -noupdate /tx_modul_tb/baud_sel
add wave -noupdate /tx_modul_tb/tx_baud
add wave -noupdate /tx_modul_tb/tx_in
add wave -noupdate /tx_modul_tb/tx_out
add wave -noupdate /tx_modul_tb/tx_start
add wave -noupdate -color Magenta /tx_modul_tb/tx_busy
add wave -noupdate /tx_modul_tb/baud_gen_init/tx_baud
add wave -noupdate /tx_modul_tb/baud_gen_init/rx_tick
add wave -noupdate /tx_modul_tb/baud_gen_init/M
add wave -noupdate /tx_modul_tb/baud_gen_init/baud_clk_counter
add wave -noupdate /tx_modul_tb/baud_gen_init/tx_counter
add wave -noupdate -color Red /tx_modul_tb/tx_gen_init/tx_out
add wave -noupdate /tx_modul_tb/tx_gen_init/state
add wave -noupdate /tx_modul_tb/tx_gen_init/bit_count
add wave -noupdate /tx_modul_tb/tx_gen_init/tx_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 276
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ns} {2264 ns}
