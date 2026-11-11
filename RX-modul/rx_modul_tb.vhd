---------------------------------------------------------------------------------
-- Testbench of d4_pwm
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rx_modul_tb is
end rx_modul_tb;


architecture SimulationModel of rx_modul is

   -----------------------------------------------------------------------------
   -- Constant declaration
   -----------------------------------------------------------------------------
   constant c_ClkPer : time := 20 ns;      -- 50 MHz


   -----------------------------------------------------------------------------
   -- Component declarasion
   -----------------------------------------------------------------------------
   component rx_modul
      port (
 		clk 			: in std_logic;
		rst 			: in std_logic;
		rx_in 		: in std_logic;
		rx_tick 		: in std_logic;
		rx_data 		: out std_logic_vector(7 downto 0);
		rx_done 		: out std_logic
      );
   end component rx_modul;


   -----------------------------------------------------------------------------
   -- Signal declaration
   -----------------------------------------------------------------------------
   -- DUT signals
   signal clk      : std_logic;
   signal rst      : std_logic;
	signal rx_in 	 : std_logic;
	signal rx_tick  : std_logic;
	signal rx_data  : std_logic_vector(7 downto 0) := "10010110";
	signal rx_done  : std_logic;
   signal rx_out	 : std_logic;  

begin

   -----------------------------------------------------------------------------
   -- Component instantiations
   -----------------------------------------------------------------------------
   i_d4_pwm: component d4_pwm
    port map (
      clk       => clk,
      rst       => rst,
		rx_in 	 => rx_in,
		rx_tick	 => rx_tick,
      rx_data   => rx_data,
		rx_done 	 => rx_done,
      rx_out 	 => rx_out
      );


   -----------------------------------------------------------------------------
   -- purpose: Generation of clock
   -- type   : sequential
   -- inputs : none
   -- outputs: clk
   -----------------------------------------------------------------------------
   p_clk: process is
   begin  -- process p_clk
      clk <= '0';
      wait for c_ClkPer/2;
      clk <= '1';
      wait for c_ClkPer/2;
   end process p_clk;


   -----------------------------------------------------------------------------
   -- purpose: Generation of reset
   -- type   : sequential
   -- inputs : none
   -- outputs: reset
   -----------------------------------------------------------------------------
   p_rst: process is
   begin  -- process p_rst
      rst <= '0';
      wait for 2.2*c_ClkPer;
      rst <= '1';
      wait;
   end process p_rst;


   -----------------------------------------------------------------------------
   -- purpose: Main process
   -- type   : sequential
   -- inputs : 
   -----------------------------------------------------------------------------
   p_main: process
   begin
      -- Initialize signals
      rx_data  <= "10010110";

      -- Initialize variables
      -- Wait for falling edge after reset
      wait until rst = '1';
      wait until rising_edge(clk);

      -- Create data signal and check response
      for i in 0 to 7 loop
			rx_data <= std_logic_vector(to_unsigned(i, 8));
			wait for 30 * c_ClkPer;
      end loop;

      -- Terminate testbench
      wait for 5 * c_ClkPer;
      report "Simulering er ferdig!" severity note;
		wait;
   end process p_main;

end architecture SimulationModel;