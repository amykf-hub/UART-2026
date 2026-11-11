library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity baud_generator is

	generic (
        F_CLK    			: integer    := 50_000_000;  	-- 50 MHz systemklokke 
        --BAUD_RATE	  		: integer    := 9600; 	 		-- 
        OVERSAMPLE     	: integer 	 := 8        		-- 
    );
	 
	port (
		clk: 		in std_logic;
		rst: 		in std_logic;
		
		baud_sel in std_logic_vector (1 downto 0);
		
		tx: 		out std_logic;
		rx: 		out std_logic
	);

end entity baud_generator;

architecture rtl of baud_generator is
	--Antall klokkesykluser
    constant M : integer := F_CLK / (BAUD_RATE * OVERSAMPLE);

	--Teller for 8x baudrate
    signal baud_clk_counter : natural range 0 to M-1;
	 
	--For å telle 8 ticks for Rx og én for Tx
	 signal tx_counter : natural range from 0 to OVERSAMPLE - 1 := 0;
	
	--signal tick_8x : integer; 

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
            baud_clk_counter <= 0;
				tx_counter 		  <= 0;
				rx 				  <= '0';
				tx               <= '0';
				
            --tick_8x <= '0';

        elsif rising_edge(clk) then
		  
		  rx <= '0';
		  tx <= '0';
			
            if baud_clk_counter = M - 1 then
                baud_clk_counter <= 0;
					 --tick_8x <= '1';
					 rx <= '1';
					 
					 if tx_counter <= OVERSAMPLE - 1 then
						tx_counter <= '0';
						tx <= '1';
					 else
						tx_counter <= tx_counter + 1;
                   
						 --tick_8x <= '0';
                end if;
				else
					baud_clk_counter <= baud_clk_counter + 1;
				end if;
			end if;	
   end process;
end architecture rtl;