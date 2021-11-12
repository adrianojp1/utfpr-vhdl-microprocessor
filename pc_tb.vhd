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
            endereco_i  :   in  unsigned(23 downto 0);
            endereco_o  :   out unsigned(23 downto 0)
        );
    end component pc;

    signal  period_time :   time      :=  100 ns;
    signal  finished    :   std_logic := '0';

    signal  clk         :   std_logic;
    signal  rst         :   std_logic;
    signal  wr_en       :   std_logic;
    signal  endereco_i      :   unsigned(23 downto 0);
    signal  endereco_o      :   unsigned(23 downto 0);

begin
    uut: pc port map(
        clk     =>  clk,
        rst     =>  rst,
        wr_en   =>  wr_en,
        endereco_i  =>  endereco_i,
        endereco_o  =>  endereco_o
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
        endereco_i<=x"000000";
        wait for period_time;
        endereco_i<=x"001101";
        wait for period_time;
        endereco_i<=x"00AA11";
        
        wait for period_time*3;
        wr_en<='0';
        endereco_i<=x"001234";

        wait;
    end process;
end architecture a_pc_tb;