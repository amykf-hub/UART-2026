library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity baud_generator is

	generic (
        F_CLK    			: integer    := 50_000_000;  	-- 50 MHz systemklokke 
        BAUD_RATE	  		: integer    := 9600; 	 		-- 
        OVERSAMPLE     	: integer 	 := 8        		-- 
    );
	 
	port (
		clk: 		in std_logic;
		rst: 		in std_logic;
		tick_8x: out std_logic
	);

end entity baud_generator;

architecture rtl of baud_generator is

    constant M : integer := F_CLK / (BAUD_RATE * OVERSAMPLE);

    signal baud_clk_counter : natural range 0 to M-1;

begin
    process(clk, rst)
    begin
        if rst = '0' then
            baud_clk_counter  <= 0;
            tick_8x <= '0';

        elsif rising_edge(clk) then
            if baud_clk_counter = M - 1 then
                baud_clk_counter <= 0;
					 tick_8x <= '1';

                else
                    baud_clk_counter <= baud_clk_counter + 1;
						  tick_8x <= '0';
                end if;
			end if;
    end process p_pwm_single;
end architecture rtl;