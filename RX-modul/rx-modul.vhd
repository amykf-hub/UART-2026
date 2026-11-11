library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rx_modul is 
	port (
		baud_generator : in std_logic;
		tx_input 		: in std_logic;
		
	);