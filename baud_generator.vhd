library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity baud_generator is

	generic (
        F_CLK    			: integer    := 50_000_000;  	-- 50 MHz systemklokke 
        OVERSAMPLE     		: integer 	 := 8        		-- 8x oversampling
    );
	 
	port (
		clk: 		in std_logic;
		rst: 		in std_logic;
		baud_sel : 	in std_logic_vector (1 downto 0);
		tx_baud: 	out std_logic;
		rx_tick: 	out std_logic
	);

end entity baud_generator;

architecture rtl of baud_generator is
	--Antall klokkesykluser
    signal M : integer := F_CLK / (9600 * OVERSAMPLE);

	--Teller for 8x baudrate
    signal baud_clk_counter : integer range 0 to 1000 := 0;
	 
	--For å telle 8 ticks for Rx og én for Tx
	 signal tx_counter : natural range from 0 to OVERSAMPLE - 1 := 0;

begin
	process(baud_sel)
	begin
		case baud_sel is 
			when "00" => M <= F_CLK / (OVERSAMPLE * 9600);
			when "01" => M <= F_CLK / (OVERSAMPLE * 19200);
			when "10" => M <= F_CLK / (OVERSAMPLE * 38400);
			when "11" => M <= F_CLK / (OVERSAMPLE * 115200);
			when others => M <= F_CLK / (OVERSAMPLE * 9600);
		end case;
	end process;

   process(clk, rst)
    begin
        if rst = '0' then
            baud_clk_counter	 <= 0;
				tx_counter 		 <= 0;
				rx_tick 		 <= '0';
				tx_baud          <= '0';

        elsif rising_edge(clk) then
		  
		  rx_tick <= '0';
		  tx_baud <= '0';
			
            if baud_clk_counter = M - 1 then
                baud_clk_counter <= 0;
					 rx_tick <= '1';
					 
					 if tx_counter = OVERSAMPLE - 1 then
						tx_counter <= '0';
						tx_baud <= '1';
					 else
						tx_counter <= tx_counter + 1;
                end if;
			else
					baud_clk_counter <= baud_clk_counter + 1;
			end if;
		end if;	
   end process;
end architecture rtl;
