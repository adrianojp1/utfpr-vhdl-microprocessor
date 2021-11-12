library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
    port(
        clk         :   in  std_logic;
        rst         :   in  std_logic;
        wr_en       :   in  std_logic;
        instr       :   in  unsigned(15 downto 0);
        pc_o        :   in  unsigned(23 downto 0);
        pc_i        :   out unsigned(23 downto 0);
        pc_wr_en    :   out STD_LOGIC;
        rom_wr_en   :   out STD_LOGIC
    );
end entity uc;

architecture a_uc of uc is
    component maq_estados is
        port(
            clk    : IN std_logic ;
            rst    : IN std_logic ;
            enable : IN std_logic ;
            estado : OUT std_logic
        );
    end component;
    
    signal opcode    : unsigned(3 downto 0);
    signal jump_imm  : unsigned(23 downto 0);
    signal jump_en   : STD_LOGIC;
    signal estado    : STD_LOGIC;
begin
    
    maq_estados0: maq_estados port map(
        clk    => clk,
        rst    => rst,
        enable => wr_en,
        estado => estado
    );
    
    opcode                <= instr(15 downto 12);
    jump_imm(23 downto 8) <= x"0000";
    jump_imm(7 downto 0)  <= instr(7  downto 0);
    
    jump_en <= '1' when opcode="1111" else
    '0';
    
    pc_i <= pc_o+1    when wr_en='1' and estado='1' and jump_en='0' else
    jump_imm  when wr_en='1' and estado='1' and jump_en='1' else
    pc_o;
    
    pc_wr_en <= '1' when estado='1' else
                '0';
   
    rom_wr_en <= '0' when estado='1' else
                 '1';

end architecture a_uc;