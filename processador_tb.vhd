library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador_tb is
end entity;

architecture a_processador_tb of processador_tb is
    component processador is
        port
        (
            clk     : IN std_logic ;
            rst     : IN std_logic ;
            wr_en   : IN STD_LOGIC ;
            cte_in  : IN unsigned (15 downto 0);
            ula_out : OUT unsigned (15 downto 0)
        );
    end component;
    
    constant period_time     : time      := 100 ns;
    signal   finished        : STD_LOGIC := '0';
    signal   clk, rst, wr_en : std_logic;
    signal   cte_in, ula_out : unsigned(15 downto 0);
begin
    uut: processador port map(
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        cte_in => cte_in,
        ula_out => ula_out
    );

    reset_global: process
    begin
        rst <= '1';
        wait for period_time*2;
        rst <= '0';
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
        cte_in <= "0000000000000001";
        wait;
    end process;
        
end architecture;