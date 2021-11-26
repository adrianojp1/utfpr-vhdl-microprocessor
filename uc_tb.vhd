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
            cte         :   in  unsigned(7 downto 0);
            prev_carry  :   in  std_logic;
            pc_o        :   in  unsigned(7 downto 0);
            pc_i        :   out unsigned(7 downto 0);
            mem_read    :   out std_logic;
            pc_write    :   out std_logic;
            reg_write   :   out std_logic;
            carry_write :   out std_logic;
            ula_op      :   out unsigned(1 downto 0);    
            estado      :   out unsigned(1 downto 0)    
        );
    end component uc;

    component pc is
        port(
            clk         :   in  std_logic;
            rst         :   in  std_logic;
            wr_en       :   in  std_logic;
            endereco_i  :   in  unsigned(7 downto 0);
            endereco_o  :   out unsigned(7 downto 0)
        );
    end component pc;

    signal period_time :   time      :=  100 ns;
    signal finished    :   std_logic := '0';
    
    signal clk         :   std_logic;
    signal rst         :   std_logic;

    signal opcode      :   unsigned(3 downto 0);
    signal cte         :   unsigned(7 downto 0);
    signal prev_carry  :   std_logic;
    signal pc_o        :   unsigned(7 downto 0);
    signal pc_i        :   unsigned(7 downto 0);

    signal mem_read    :   std_logic;
    signal pc_write    :   std_logic;
    signal reg_write   :   std_logic;
    signal carry_write :   std_logic;
    signal ula_op      :   unsigned(1 downto 0);
    signal estado      :   unsigned(1 downto 0);
begin

    uut: uc port map(
        clk         => clk,
        rst         => rst,
        opcode      => opcode,
        cte         => cte,
        prev_carry  => prev_carry,
        pc_o        => pc_o,
        pc_i        => pc_i,
        mem_read    => mem_read,
        pc_write    => pc_write,
        reg_write   => reg_write,
        ula_op      => ula_op,
        estado      => estado
    );

    pc0: pc port map(
        clk         =>  clk,
        rst         =>  rst,
        wr_en       =>  pc_write,
        endereco_i  =>  pc_i,
        endereco_o  =>  pc_o
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

        wait for period_time*2.5;
        rst<='0';
        opcode <= x"0";
        cte <= x"00";
        prev_carry<='0';
        
        wait for period_time*3; -- espera todos os estados
        opcode <= x"1";
        cte <= x"07";
        
        wait for period_time*3;
        opcode <= x"2";
        cte <= x"0F";
        
        wait for period_time*3;
        opcode <= x"3";
        cte <= x"00";
        
        wait for period_time*3;
        opcode <= x"4";
        cte <= x"00";
        
        wait for period_time*3;
        opcode <= x"5";
        cte <= x"00";
        
        wait for period_time*3;
        opcode <= x"6";
        cte <= x"00";
        
        wait for period_time*3;
        opcode <= x"7";
        cte <= x"00";
        
        wait for period_time*3;
        opcode <= x"8";
        cte <= x"02";
        prev_carry<='1';
        
        wait for period_time*3;
        opcode <= x"0";
        cte <= x"00";
        prev_carry<='0';
        
        wait for period_time*3;
        opcode <= x"8";
        cte <= x"FB";
        prev_carry<='1';
        
        wait for period_time*3;
        opcode <= x"0";
        cte <= x"00";
        prev_carry<='0';
        
        wait for period_time*30;
        rst<='1';

        wait;
    end process;

end architecture a_uc_tb;