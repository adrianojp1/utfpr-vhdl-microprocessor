library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_tb is
end entity;


architecture a_pc_tb of pc_tb is
    component pc is
        port(
            clk     :   in  std_logic;
            rst     :   in  std_logic;
            wr_en   :   in  std_logic;
            data_in :   in  unsigned(7 downto 0);
            data_out:   out unsigned(7 downto 0)
        );
    end component pc;

    signal  data_s      :   unsigned(7 downto 0);
    signal  period_time :   time      :=  100 ns;
    signal  finished    :   std_logic := '0';

    signal  clk         :   std_logic;
    signal  rst         :   std_logic;
    signal  wr_en       :   std_logic;
    signal  data_in     :   unsigned(7 downto 0);
    signal  data_out    :   unsigned(7 downto 0);

begin
    uut: pc port map(
        clk=>clk,
        rst=>rst,
        wr_en=>wr_en,
        data_in=>data_in,
        data_out=>data_out
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

    reset_proc: process
    begin
        rst<='0';
        wait for period_time;
        rst<='1';
        wait for period_time*2;
        rst<='0';
        wait;
    end process reset_proc;

    process
    begin
        wr_en<='0';
        wait for period_time*3;
        wr_en<='1';
        data_in<="00000000";
        wait for period_time;
        data_in<="00011101";
        
        wait for period_time*3;
        wr_en<='0';
        data_in<="00101000";

        wait;
    end process;
end architecture a_pc_tb;