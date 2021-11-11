library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity proto_controle_tb is 
end entity proto_controle_tb;

architecture a_proto_controle_tb of proto_controle_tb is
    component proto_controle is
        port(
            clk         :   in  std_logic;
            rst         :   in  std_logic;
            enable      :   in  std_logic;
            data_o      :   out unsigned(7 downto 0)
        );
    end component proto_controle;

    signal  period_time :   time      :=  100 ns;
    signal  finished    :   std_logic := '0';
    signal  data_o      :   unsigned(7 downto 0);

    signal  clk         :   std_logic;
    signal  rst         :   std_logic;
    signal  enable      :   std_logic;
begin
    uut: proto_controle port map(
        clk     =>  clk,
        rst     =>  rst,
        enable  =>  enable,
        data_o  =>  data_o
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
        enable<='1';
        wait for period_time*3;

        wait;
    end process;

end architecture a_proto_controle_tb;