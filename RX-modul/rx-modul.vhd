library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rx_modul is 
	port (
		clk 				: in std_logic;
		rst 				: in std_logic;
		rx_in 			: in std_logic;
		rx_tick 			: in std_logic;
		rx_data 			: out std_logic_vector(7 downto 0);
		rx_done 			: out std_logic;
		rx_buffer		: buffer std_logic_vector(127 downto 0);
		parity_wrong 	: out std_logic
	);
end entity rx_modul;

architecture RTL of rx_modul is
	type state_type is (IDLE, START, WAIT_START, SAMPLING, PARITY_CHECK, STOPP, DONE);
	signal state : state_type := IDLE;
	
	signal sample_count : integer range 0 to 7 := 0;
	signal bit_count : integer range 0 to 7 := 0;
	signal samples_reg: std_logic_vector(7 downto 0) := (others => '0');
	signal shift_reg: std_logic_vector(7 downto 0) := (others => '0');
	signal buffer_counter : integer range 0 to 16 := 0;
	signal buffer_full : std_logic;

begin
	p1_process: process(clk, rst)
	
		variable majority_check 	: integer range 0 to 5 := 0;
		variable majority_set 		: std_logic;
		variable parity_bit_check  : std_logic;
		
	begin 
	
		if rst = '0' then
			state 				<= IDLE;
			sample_count 		<= 0;
			bit_count 			<= 0;
			shift_reg 			<= (others => '0');
			samples_reg 		<= (others => '0');
			rx_done				<= '0';
			rx_data				<= (others => '0');
			majority_check 	:= 0;
			majority_set		:= '0';
			
			--sletter buffer innhold
			rx_buffer 			<= (others => '0');
			buffer_counter 	<= 0;
			buffer_full 		<= '0';
			
			parity_bit_check 	:= '0';
			parity_wrong 		<= '0';
		
		elsif rising_edge(clk) then
		
			rx_done <= '0';
			if rx_tick = '1' then
			
					case state is
						when IDLE =>
							parity_wrong   <= '0';
							sample_count 	<= 0;
							bit_count 		<= 0;
							
							if rx_in = '0' then 
								state <= START;
							end if;

						when START =>
							if sample_count = 3 then
								if rx_in = '0' then
									sample_count <= 0; 
									state <= WAIT_START;
								else 
									state <= IDLE;
								end if;
							else
								sample_count <= sample_count + 1;
							end if;
							
						when WAIT_START =>
							if sample_count = 3 then
									sample_count <= 0; 
									state <= SAMPLING;
							else
								sample_count <= sample_count + 1;
							end if;
							
						when SAMPLING => 
							if sample_count = 7 then
								sample_count <= 0;
								
								 majority_check := 0;
								
								--Teller antall høye bits i punktprøve 2 til 6 (5 punktprøver)
								for i in 2 to 6 loop
									if samples_reg(i) = '1' then
										majority_check := majority_check + 1;
									end if;
								end loop; 
								
								--Sjekker om det er flest høye eller lave bits og setter majoritets_set til majoriteten
								if majority_check < 3 then
									majority_set := '0';
								else
									majority_set := '1';
								end if;
								
								--Lagrer alle majoritetsbitene i shift_reg
								shift_reg <= majority_set & shift_reg(7 downto 1);
								
								
								
								if bit_count = 7 then
									bit_count <= 0;								
									state <= PARITY_CHECK;
								else
									bit_count <= bit_count + 1;
								end if;
							else	
								samples_reg(sample_count) <= rx_in;
								sample_count <= sample_count + 1;
							end if;
							
						when PARITY_CHECK =>
						
						--- Sampler paritetsbitten med majoritetsbeslutning
							if sample_count = 7 then
								sample_count <= 0;
								
								 majority_check := 0;
								
								--Teller antall høye bits i punktprøve 2 til 6 (5 punktprøver)
								for i in 2 to 6 loop
									if samples_reg(i) = '1' then
										majority_check := majority_check + 1;
									end if;
								end loop; 
								
								--Sjekker om det er flest høye eller lave bits og setter majoritets_set til majoriteten
								if majority_check < 3 then
									majority_set := '0';
								else
									majority_set := '1';
								end if;
								
								parity_bit_check := shift_reg(0)	xor shift_reg(1)
																			  xor shift_reg(2)
																			  xor shift_reg(3)
																			  xor shift_reg(4) 
																			  xor shift_reg(5)
																			  xor shift_reg(6) 
																			  xor shift_reg(7);
													
								if parity_bit_check = majority_set then
									parity_wrong <= '0';
								else
									parity_wrong <= '1';
								end if;
								
								state <= STOPP;
									
							else	
								samples_reg(sample_count) <= rx_in;
								sample_count <= sample_count + 1;
							end if;
								
						when STOPP =>
							if sample_count = 3 then
								if rx_in = '1' then
									sample_count <= 0; 
									state <= DONE;
								else 
									state <= IDLE;
								end if;
							else
								sample_count <= sample_count + 1;
							end if;
								
								
						
						when DONE =>
							rx_data <= shift_reg;
							
							--Sjekker om det er plass i bufferen
							if buffer_counter < 16 then
								--Lagrer alle data-bytene i rx_buffer
								 rx_buffer <= shift_reg & rx_buffer(127 downto 8);
								 buffer_counter <= buffer_counter + 1;

								 if buffer_counter = 15 then
									  buffer_full <= '1';
								 end if;
							end if;
							
							rx_done <= '1';
							state <= IDLE;
					end case;
			end if;
		end if;
	end process;
end architecture RTL;	