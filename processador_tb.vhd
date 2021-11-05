library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador_tb is 
end entity;

architecture a_processador_tb of processador_tb is
    component processador 
        port(
            clk :   in  std_logic;
            rst :   in  std_logic
        );
    end component;

    signal clk, rst  :   std_logic; 
begin 
    uut: processador port map(
        clk => clk,
        rst => rst
    );

    clk_process: process
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
    end process clk_process;

    reset_global: process
    begin
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait;
    end process reset_global;
    
end architecture;