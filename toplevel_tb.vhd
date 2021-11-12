library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel_tb is
end entity toplevel_tb;

architecture a_toplevel_tb of toplevel_tb is
    component toplevel is
        port(
            clk     :   in  std_logic;
            rst     :   in  std_logic;
            wr_en   :   in  std_logic
        );
    end component toplevel;

    signal  period_time     :  time      :=  100 ns;
    signal  finished        :  std_logic := '0';
    signal  clk,rst,wr_en   :  std_logic;

begin
    uut: toplevel port map(
        clk     =>  clk,
        rst     =>  rst,
        wr_en   =>  wr_en
    );

    clk_proc:   process
    begin
        while finished/='1' loop
            clk<='0';
            wait for period_time/2;
            clk<='1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;

    sim_time_proc:  process
    begin
        wait for 10 us;
        finished<='1';
        wait;
    end process sim_time_proc;

    process
    begin
        rst<='1';
        wait for period_time*2;
        rst<='0';
        
        wr_en<='1';
        wait for period_time*20;
        
        wr_en<='0';
        wait for period_time*5;

        wr_en<='1';
        wait for period_time*10;

        wr_en<='0';
        
        rst<='1';
        wait for period_time*2;
        rst <= '0';
        
        wait;
    end process;
end architecture a_toplevel_tb;