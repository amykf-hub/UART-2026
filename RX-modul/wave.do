onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /rx_modul_tb/clk
add wave -noupdate /rx_modul_tb/rst
add wave -noupdate /rx_modul_tb/baud_sel
add wave -noupdate /rx_modul_tb/rx_tick
add wave -noupdate /rx_modul_tb/rx_in
add wave -noupdate -color Red /rx_modul_tb/parity_wrong
add wave -noupdate /rx_modul_tb/baud_gen_init/tx_baud
add wave -noupdate /rx_modul_tb/baud_gen_init/rx_tick
add wave -noupdate /rx_modul_tb/baud_gen_init/M
add wave -noupdate /rx_modul_tb/baud_gen_init/baud_clk_counter
add wave -noupdate /rx_modul_tb/baud_gen_init/tx_counter
add wave -noupdate /rx_modul_tb/rx_gen_init/rx_buffer
add wave -noupdate /rx_modul_tb/rx_gen_init/parity_wrong
add wave -noupdate /rx_modul_tb/rx_gen_init/state
add wave -noupdate /rx_modul_tb/rx_gen_init/sample_count
add wave -noupdate /rx_modul_tb/rx_gen_init/bit_count
add wave -noupdate /rx_modul_tb/rx_gen_init/samples_reg
add wave -noupdate /rx_modul_tb/rx_gen_init/shift_reg
add wave -noupdate /rx_modul_tb/rx_gen_init/buffer_counter
add wave -noupdate /rx_modul_tb/clk
add wave -noupdate /rx_modul_tb/rst
add wave -noupdate /rx_modul_tb/baud_sel
add wave -noupdate /rx_modul_tb/rx_tick
add wave -noupdate /rx_modul_tb/rx_in
add wave -noupdate /rx_modul_tb/parity_wrong
add wave -noupdate /rx_modul_tb/baud_gen_init/tx_baud
add wave -noupdate /rx_modul_tb/baud_gen_init/rx_tick
add wave -noupdate /rx_modul_tb/baud_gen_init/M
add wave -noupdate /rx_modul_tb/baud_gen_init/baud_clk_counter
add wave -noupdate /rx_modul_tb/baud_gen_init/tx_counter
add wave -noupdate /rx_modul_tb/rx_gen_init/rx_buffer
add wave -noupdate /rx_modul_tb/rx_gen_init/parity_wrong
add wave -noupdate /rx_modul_tb/rx_gen_init/state
add wave -noupdate /rx_modul_tb/rx_gen_init/sample_count
add wave -noupdate /rx_modul_tb/rx_gen_init/bit_count
add wave -noupdate /rx_modul_tb/rx_gen_init/samples_reg
add wave -noupdate /rx_modul_tb/rx_gen_init/shift_reg
add wave -noupdate /rx_modul_tb/rx_gen_init/buffer_counter
add wave -noupdate /rx_modul_tb/clk
add wave -noupdate /rx_modul_tb/rst
add wave -noupdate /rx_modul_tb/baud_sel
add wave -noupdate /rx_modul_tb/rx_tick
add wave -noupdate /rx_modul_tb/rx_in
add wave -noupdate /rx_modul_tb/parity_wrong
add wave -noupdate /rx_modul_tb/baud_gen_init/tx_baud
add wave -noupdate /rx_modul_tb/baud_gen_init/rx_tick
add wave -noupdate /rx_modul_tb/baud_gen_init/M
add wave -noupdate /rx_modul_tb/baud_gen_init/baud_clk_counter
add wave -noupdate /rx_modul_tb/baud_gen_init/tx_counter
add wave -noupdate /rx_modul_tb/rx_gen_init/rx_buffer
add wave -noupdate /rx_modul_tb/rx_gen_init/parity_wrong
add wave -noupdate /rx_modul_tb/rx_gen_init/state
add wave -noupdate /rx_modul_tb/rx_gen_init/sample_count
add wave -noupdate /rx_modul_tb/rx_gen_init/bit_count
add wave -noupdate /rx_modul_tb/rx_gen_init/samples_reg
add wave -noupdate /rx_modul_tb/rx_gen_init/shift_reg
add wave -noupdate /rx_modul_tb/rx_gen_init/buffer_counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20683 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 292
configure wave -valuecolwidth 174
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
WaveRestoreZoom {1584587 ns} {1665485 ns}
