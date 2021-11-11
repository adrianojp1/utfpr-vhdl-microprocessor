library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maq_estados_tb is
end entity;

architecture a_maq_estados_tb of maq_estados_tb is
    component maq_estados is
        port(
            clk     :   in  std_logic;
            rst     :   in  std_logic;
            enable  :   in  std_logic;
            estado  :   out  std_logic
        );
    end component;
    
    signal  clk         :   std_logic;
    signal  rst         :   std_logic;
    signal  enable      :   std_logic;
    signal  estado      :   std_logic;

    signal  period_time :   time      :=  100 ns;
    signal  finished    :   std_logic := '0';
begin
    uut: maq_estados port map(
        clk=>clk,
        rst=>rst,
        enable=>enable,
        estado=>estado
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
        wait for period_time;
        rst<='1';
        enable<='0';
        wait for period_time*2;      
        rst<='0';

        wait for period_time*3;
        enable<='1';

        wait for period_time*5;
        enable<='0';

        wait;
    end process;
end architecture a_maq_estados_tb;