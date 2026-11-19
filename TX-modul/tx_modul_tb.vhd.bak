---------------------------------------------------------------------------------
-- Testbench of RX modul
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tx_modul_tb is
end tx_modul_tb;


architecture SimulationModel of tx_modul_tb is

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
	signal tx_baud  : std_logic := '0';
	
	--Signal fra tx_modul
	signal tx_in 			: std_logic_vector(7 downto 0) := (others => '0');
	signal tx_out 	 	  : std_logic := '1';
	signal tx_start  	  : std_logic := '0';
	signal tx_busy  	  : std_logic;  
	


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
		baud_sel  => baud_sel, --kommer fra baud.gen
		rx 		 => rx_tick,  --tx kommer fra utgang av baud.gen 
		tx 		 => tx_baud	  --tx kommer fra utgang av baud.gen
		);

--Initialisering av rx-modul
	tx_gen_init : entity work.tx_modul 
		port map (
		clk          => clk,
      rst          => rst,
		tx_in 	    => tx_in,
		tx_out 	    => tx_out,
		tx_baud	    => tx_baud,
      tx_start     => tx_start,
		tx_busy 	 	 => tx_busy
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
	procedure start_condition(
				 data_byte   : std_logic_vector(7 downto 0);
				 bit_time    : time
	) is
	
   begin
		
	--start sending
		tx_start <= '1';
		tx_in <= data_byte;
		wait for bit_time;
		tx_start <= '0';
	end procedure;
	
	begin
		wait until rst = '1';
		wait for 100 ns;
		
--Tester ulike baudrates'

		--Baudrate 9600
		baud_sel <= "00";
		wait for 10 us;

      start_condition("00000001", 20 ns);
		wait until tx_busy = '0';

		--Baudrate 115200
		baud_sel <= "11";
		wait for 10 us;
		
		start_condition("01010101", 20 ns);
      wait until tx_busy = '0';
		
		--sim ferdig
      assert false
			report "Simulering er ferdig!" severity failure;
  end process p_main;
end architecture SimulationModel;