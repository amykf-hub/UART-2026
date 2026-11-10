library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CTRL_module is
    port (
	 rst 	 			: in  std_logic;
	 clk				: in  std_logic;
	 
	 baud_tick		: in  std_logic;
	 bit_done 		: in  std_logic;
	 
	 tx_reg			: in  std_logic;
	 tx_shift		: in  std_logic;
	 clear_bit_cnt	: in  std_logic;
	 
	 tx_done			: in  std_logic;
    );
end entity CTRL_module;

architecture behavorial of CTRL_module is

	
begin
--Process 1 (klokke og rst)----
	clk_process : process(rst, clk)
	begin 
		if rst = '1' then 
			current_state <= IDLE;
		elsif rising_edge(clk) then
			current_state <= next_state;
		end if;
	end process clk_process;
	
--Process 2 (FSM logikk)---

	p_state : process(current_state, tx_start, baud_tick, bit_done)
		begin
			next_state 		<= current_state;
			tx_reg 			<= 0;
			tx_shift 		<= 0;
			clear_bit_cnt 	<= 0;
			
		
end architecture behavorial;