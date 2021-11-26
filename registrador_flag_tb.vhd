library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registrador_flag_tb is
end entity;

architecture a_registrador_flag_tb of registrador_flag_tb is
    component registrador_flag is
        port(
            clk         :   in  std_logic;
            rst         :   in  std_logic;
            wr_en       :   in  std_logic;
            data_in     :   in  std_logic;
            data_out    :   out std_logic
        );
    end component;

    constant period_time        :   time := 100 ns;
    signal   finished           :   std_logic := '0';
    signal   clk, rst, wr_en    :   std_logic;
    signal   data_in, data_out  :   std_logic;
begin
    uut: registrador_flag port map(
        clk         =>  clk,
        rst         =>  rst,
        wr_en       =>  wr_en,
        data_in     =>  data_in,
        data_out    =>  data_out
    );

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
        rst <= '1';
        wait  for period_time*2;
        rst <= '0';

        wait for 200 ns;
        wr_en <= '0';
        data_in <= '0';

        wait for 100 ns;
        data_in <= '1';
        wr_en <= '1';

        wait for 100 ns;
        wr_en <= '0';
        data_in <= '0';

        wait for 100 ns;
        data_in <= '1';

        wait for 100 ns;
        rst <= '1';

        wait;
    end process;


end architecture a_registrador_flag_tb;