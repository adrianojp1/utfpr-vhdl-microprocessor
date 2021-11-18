library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity uc_tb is 
end entity uc_tb;

architecture a_uc_tb of uc_tb is
    component uc is
        port(
            clk         :   in  std_logic;
            rst         :   in  std_logic;
            opcode      :   in  unsigned(3 downto 0);
            cte         :   in  unsigned(6 downto 0);
            pc_o        :   in  unsigned(7 downto 0);
            pc_i        :   out unsigned(7 downto 0);
            mem_read    :   out std_logic;
            pc_write    :   out std_logic;
            reg_write   :   out std_logic;
            ula_op      :   out unsigned(1 downto 0)
        );
    end component uc;

    signal period_time :   time      :=  100 ns;
    signal finished    :   std_logic := '0';
    
    signal clk         :   std_logic;
    signal rst         :   std_logic;

    signal opcode      :   unsigned(3 downto 0);
    signal cte         :   unsigned(6 downto 0);
    signal pc_o        :   unsigned(7 downto 0);
    signal pc_i        :   unsigned(7 downto 0);

    signal mem_read    :   std_logic;
    signal pc_write    :   std_logic;
    signal reg_write   :   std_logic;
    signal ula_op      :   unsigned(1 downto 0);
begin

    uut: uc port map(
        clk => clk,
        rst => rst,
        opcode => opcode,
        cte => cte,
        pc_o => pc_o,
        pc_i => pc_i,
        mem_read => mem_read,
        pc_write => pc_write,
        reg_write => reg_write,
        ula_op => ula_op
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
        pc_o <= x"00";
        opcode <= x"0";
        cte <= "0000000";
        
        wait for period_time*3; -- espera todos os estados
        pc_o <= x"01";
        opcode <= x"1";
        cte <= "0000011";
        
        wait for period_time*3;
        pc_o <= x"02";
        opcode <= x"2";
        cte <= "0001111";
        
        wait for period_time*3;
        pc_o <= x"03";
        opcode <= x"3";
        cte <= "1000000";
        
        wait for period_time*3;
        pc_o <= x"04";
        opcode <= x"4";
        cte <= "1000000";
        
        wait for period_time*3;
        pc_o <= x"05";
        opcode <= x"5";
        cte <= "1000000";
        
        wait for period_time*3;
        pc_o <= x"06";
        opcode <= x"6";
        cte <= "1000000";
        
        wait for period_time*3;
        pc_o <= x"07";
        opcode <= x"7";
        cte <= "1000000";

        wait for period_time*3;
        rst<='1';

        wait;
    end process;

end architecture a_uc_tb;