library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end entity;

architecture a_rom_tb of rom_tb is
    component rom is 
        port
        (
            
            clk         : in std_logic;
            endereco    : in unsigned(23 downto 0);
            dado        : out unsigned(15 downto 0)
        );
    end component;
    
    signal  clk         :   std_logic;
    signal  endereco    :   unsigned(23 downto 0);
    signal  dado        :   unsigned(15 downto 0);

    signal  finished    :   std_logic   := '0';
    signal  period_time :   time        := 100 ns;
begin 

    uut: rom port map(
        clk=>clk,
        endereco=>endereco,
        dado=>dado
    );

    clk_proc:   process
    begin
        while finished /= '1' loop
            clk<='0';
            wait for period_time/2;
            clk<='1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;

    sim_time_proc: process
    begin
        wait for 10 us;
        finished<='1';
        wait;
    end process sim_time_proc;

    
    process
    begin
        wait for period_time*2;
        endereco <= "000000";
        wait for period_time*2;
        endereco <= "000001";
        wait for period_time*2;
        endereco <= "000010";
        wait for period_time*2;
        endereco <= "000011";
        wait for period_time*2;
        endereco <= "000100";
        wait for period_time*2;
        endereco <= "010000";

        wait;
    end process;

end architecture;