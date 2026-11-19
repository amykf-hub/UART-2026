library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tx_modul is 
	port (
		clk 				: in std_logic;
		rst 				: in std_logic;
		tx_baud		 	: in std_logic;
		tx_start		 	: in std_logic;
		tx_in 			: in std_logic_vector(7 downto 0);
		tx_out 			: out std_logic;
		tx_busy 			: out std_logic
	);
end entity tx_modul;

architecture RTL of tx_modul is
	type state_type is (IDLE, START, DATA, PARITY, STOPP);
	signal state : state_type := IDLE;
	
	signal bit_count : integer range 0 to 7 := 0;
	signal tx_data: std_logic_vector(7 downto 0) := (others => '0');
	
		
begin
	p1_process: process(clk, rst)

		variable parity_bit : std_logic;
		
	begin 
	
		if rst = '0' then
			state 				<= IDLE;
			bit_count 			<= 0;
			tx_data 				<= (others => '0');
			tx_busy				<= '0';
			tx_out 				<= '1';
		
			parity_bit 	:= '0';

		
		elsif rising_edge(clk) then
		
			if state = IDLE and tx_start = '1' then
					tx_data <= tx_in;
					tx_busy <= '1';
					state <= START;
							
			elsif tx_baud = '1' then
			
					case state is
					
						when IDLE =>	
							tx_busy 		<= '0';
							tx_out 		<= '1';
							bit_count 	<= 0;
														

						when START =>
							tx_out 	<= '0';
							tx_busy 	<= '1';
							state 	<= DATA;
							
						when DATA=> 	
							tx_out <= tx_data(bit_count);
							
							if bit_count = 7 then
								bit_count <= 0;								
								state <= PARITY;
							else
								bit_count <= bit_count + 1;
							end if;
						
						when PARITY =>
								
								parity_bit := tx_data(0) xor tx_data(1)
																  xor tx_data(2)
																  xor tx_data(3)
																  xor tx_data(4) 
																  xor tx_data(5)
																  xor tx_data(6) 
																  xor tx_data(7);
								tx_out <= parity_bit;
								state <= STOPP;
								
						when STOPP =>
							tx_out <= '1';
							state <= IDLE;
							tx_busy <= '0';
							
					end case;
			end if;
		end if;
	end process;
end architecture RTL;	
			
		
	
	
	
	
	
	