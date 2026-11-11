-- I top-level entity:
SW : in std_logic_vector(9 downto 0);

-- I port map for baud_generator:
baud_gen_inst : entity work.baud_generator
    port map (
        clk      => MAX10_CLK1_50,
        rst      => KEY(0),
        baud_sel => SW(1 downto 0), -- SW1 og SW0 velger baudrate
        rx       => rx_tick_sig,
        tx       => tx_tick_sig
    );