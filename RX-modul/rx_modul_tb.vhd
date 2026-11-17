---------------------------------------------------------------------------------
-- Testbench of RX modul
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rx_modul_tb is
end rx_modul_tb;


architecture SimulationModel of rx_modul_tb is

   -----------------------------------------------------------------------------
   -- Constant declaration
   -----------------------------------------------------------------------------
   constant c_ClkPer : time := 20 ns;      -- 50 MHz

   -----------------------------------------------------------------------------
   -- Signal declaration
   -----------------------------------------------------------------------------
   --Signal for klokke
   signal clk      : std_logic := '0';
   signal rst      : std_logic := '0';
	signal baud_sel : std_logic_vector (1 downto 0);
	
	--Signal fra baud_generator
	signal rx_tick  : std_logic := '0';
	signal tx_tick  : std_logic := '0';
	
	--Signal fra rx_modul
	signal rx_in 	 	  : std_logic := '1';
	signal rx_data  	  : std_logic_vector(7 downto 0);
	signal rx_done  	  : std_logic;  
	signal parity_wrong : std_logic_vector (1 downto 0);

begin

   -----------------------------------------------------------------------------
   -- Component instantiations
   -----------------------------------------------------------------------------
 --Initialisering av baud_generator
  baud_gen_init : entity work.baud_generator
		generic map(
			F_CLK 		=> 50_000_000,
			OVERSAMPLE 	=> 8
		)
		
		port map (
      clk       => clk,
      rst       => rst,
		baud_sel  => baud_sel,
		rx 		 => rx_tick,
		tx 		 => tx_tick
		);

--Initialisering av rx-modul
	rx_gen_init : entity work.rx_modul 
		port map (
		clk          => clk,
      rst          => rst,
		rx_in 	    => rx_in,
		rx_tick	    => rx_tick,
      rx_data      => rx_data,
		rx_done 	 	 => rx_done,
		parity_wrong => parity_wrong
      );


--Klokke
   p_clk: process is
   begin  -- process p_clk
      clk <= '0';
      wait for c_ClkPer/2;
      clk <= '1';
      wait for c_ClkPer/2;
   end process p_clk;


--Reset
   p_rst: process is
   begin  -- process p_rst
      rst <= '0';
      wait for 2.2*c_ClkPer;
      rst <= '1';
      wait;
   end process p_rst;

--Hovedprosess
   p_main: process
	procedure send_uart_byte(
				 data_byte   : std_logic_vector(7 downto 0);
				 bit_time    : time;
				 parity_err  : boolean := false
	) is
	
		variable v_parity : std_logic := '0';
   begin
		--parity
		v_parity := '0';
		for i in 0 to 7 loop
			v_parity := v_parity xor data_byte(i);
		end loop;
		
		if parity_err then 
			v_parity := not v_parity;
		end if;
	
	--start-bit
		rx_in <= '0';
		wait for bit_time;
	--8-bits data
		for i in 0 to 7 loop
			rx_in <= data_byte(i);
			wait for bit_time;
		end loop;
	--Paritet
		rx_in <= v_parity;
		wait for bit_time;
	--stopp-bit
		rx_in <= '1';
		wait for bit_time;
	end procedure;
	
	begin
		wait until rst = '1';
		wait for 100 ns;
		
--Tester ulike baudrates'

		--Baudrate 9600
		baud_sel := "00";
		wait for 10 us;

      send_uart_byte("00000001", 104 us, parity_err => false);
      wait for 200 us;

		--Baudrate 115200
		baud_sel := "11";
		wait for 10 us;
		
		send_uart_byte("01010101", 104 us, parity_err => true);
      wait for 200 us;
		
		--sim ferdig
      report "Simulering er ferdig!" severity note;
      wait;
  end process p_main;
end architecture SimulationModel;