library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rx_modul is 
	port (
		clk 			: in std_logic;
		rst 			: in std_logic;
		rx_in 		: in std_logic;
		rx_tick 		: in std_logic;
		rx_data 		: out std_logic_vector(7 downto 0);
		rx_done 		: out std_logic
		
	);
end entity rx_modul;

architecture RTL of rx_modul is
	type state_type is (IDLE, START, SAMPLING, DONE);
	signal state : state_type := IDLE;
	
	signal sample_count : integer range 0 to 7 := 0;
	signal bit_count : integer range 0 to 7 := 0;
	signal shift_reg: std_logic_vector(7 downto 0) := (others => '0');
	
	signal store_bit : integer range 0 to 7 := 0;
begin
	p1_process: process(clk, rst)
	begin 
		if rst = '0' then
			state 			<= IDLE;
			sample_count 	<= 0;
			bit_count 		<= 0;
			shift_reg 		<= (others => '0');
			rx_done			<= '0';
			rx_data			<= (others => '0');
		
		
		elsif rising_edge(clk) then
			rx_done <= '0';
			if rx_tick = '1' then
					case state is
						when IDLE =>							
							sample_count <= 0;
							bit_count <= 0;
							
							if rx_in = '0' then 
								state <= START;
							end if;

						when START =>
							if sample_count = 3 then
								if rx_in = '0' then
									sample_count <= 0; 
									state <= SAMPLING;
								else 
									state <= IDLE;
								end if;
							else
								sample_count <= sample_count + 1;
							end if;
							
						when SAMPLING => 
							if sample_count < 7 then
								sample_count <= 0;
								shift_reg <= rx_in & shift_reg(7 downto 1);
								
								if bit_count = 7 then
									bit_count <= 0;
									state <= DONE;
								else
									bit_count <= bit_count + 1;
								end if;
							else	
								sample_count <= sample_count + 1;
							end if;
						
						when DONE =>
							rx_data <= shift_reg;
							rx_done <= '1';
							state <= IDLE;
					end case;
			end if;
		end if;
	end process;
end architecture RTL;	
			
		
	
	
	
	
	
	