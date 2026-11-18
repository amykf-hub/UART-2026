library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CTRL_modul is
    port (
        clk      : in  std_logic;
        rst      : in  std_logic;
		  
		  rx_data : in std_logic_vector (7 downto 0);
		  rx_done : in std_logic;
		  
		  btn_in : in std_logic; --knapp for forhåndsdefinert string
		  
		  tx_start : out std_logic;
		  tx_data : out std_logic_vector(7 downto 0);
		  led_blink : out std_logic
		  
    );
end entity CTRL_modul;

architecture behavorial of CTRL_modul is

	type state_type is (IDLE, BUSY, BUTTON);
	signal state: state_type;

begin

p_ctrl : process(clk, rst)
begin 
	if rst := '1'; then
		state <= IDLE;
		tx_start <= '0';
		tx_date <= (others => '0');
		
	
	case state is
		when IDLE =>
			tx_start := '0';
			
			if 
				

end architecture behavorial;