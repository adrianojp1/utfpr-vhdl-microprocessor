library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity regs8x16bits_tb is
end entity regs8x16bits_tb;

architecture a_regs8x16bits_tb of regs8x16bits_tb is
    component regs8x16bits is
        port
        (
            clk        : IN STD_LOGIC ;
            rst        : IN STD_LOGIC ;
            wr_en      : IN STD_LOGIC ;
            sel_in     : IN unsigned (2 downto 0);
            sel_out_1  : IN unsigned (2 downto 0);
            sel_out_2  : IN unsigned (2 downto 0);
            bank_in    : IN unsigned (15 downto 0);
            bank_out_1 : OUT unsigned (15 downto 0);
            bank_out_2 : OUT unsigned (15 downto 0)
        );
    end component;
    
    constant period_time                     : time      := 100 ns;
    signal   finished                        : STD_LOGIC := '0';
    signal   clk, reset, wr_en               : STD_LOGIC;
    signal   sel_in, sel_out_1, sel_out_2    : unsigned(2 downto 0);
    signal   data_in, data_out_1, data_out_2 : unsigned(15 downto 0);
begin

    uut: regs8x16bits port map(
        clk => clk, rst => reset, wr_en => wr_en,
        sel_in => sel_in,
        bank_in => data_in,
        sel_out_1 => sel_out_1, sel_out_2 => sel_out_2,
        bank_out_1 => data_out_1, bank_out_2 => data_out_2
    );
    
    reset_global: process
    begin
        reset <= '1';
        wait  for period_time*2;
        reset <= '0';
        wait;
    end process reset_global;
    
    clk_proc: process
    begin
        while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;
    
    sim_time_proc: process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process sim_time_proc;
    
    process
    begin
        wait for period_time*2;
        wr_en <= '1';
        sel_in <= "001";
        data_in <= "0000000011111111";
        sel_out_1 <= "000";
        sel_out_2 <= "001";
        
        wait for period_time;
        sel_in <= "010";
        data_in <= "1111111111111111";
        sel_out_1 <= "010";
        
        wait for period_time;
        wr_en <= '0';
        sel_in <= "001";
        data_in <= "1111111100000000";
        
        wait;
    end process;

end architecture a_regs8x16bits_tb;