library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador_tb is
end entity processador_tb;

architecture a_processador_tb of processador_tb is
    component processador is
        port(
            rst     :   in  std_logic;
            clk     :   in  std_logic;
            estado  :   out unsigned(1 downto 0);
            pc_out  :   out unsigned(7 downto 0);
            instr   :   out unsigned(15 downto 0); -- saída do registrador de instrução
            reg1    :   out unsigned(15 downto 0); -- saída 1 do banco de registradores
            reg2    :   out unsigned(15 downto 0); -- saída 2 do banco de registradores
            ula_out :   out unsigned(15 downto 0)
        );
    end component processador;

    constant    period_time : time      :=  100 ns;
    signal      finished    : std_logic := '0';

    signal      clk,rst     : std_logic;
    signal      estado      : unsigned(1 downto 0);
    signal      pc_out      : unsigned(7 downto 0);
    signal      instr       : unsigned(15 downto 0);
    signal      reg1        : unsigned(15 downto 0);
    signal      reg2        : unsigned(15 downto 0);
    signal      ula_out     : unsigned(15 downto 0);

begin
    uut: processador port map(
        clk     => clk,
        rst     => rst,
        estado  => estado,
        pc_out  => pc_out,
        instr   => instr,
        reg1    => reg1,
        reg2    => reg2,
        ula_out => ula_out
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
        wait for period_time*3;
        rst<='0';
        
        wait;
    end process;
end architecture a_processador_tb;