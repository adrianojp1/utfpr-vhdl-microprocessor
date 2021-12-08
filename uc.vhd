library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
    port(
        clk         :   in  std_logic;
        rst         :   in  std_logic;
        opcode      :   in  unsigned(3 downto 0);
        cte         :   in  unsigned(7 downto 0);
        carry       :   in  std_logic;
        pc_o        :   in  unsigned(7 downto 0);
        pc_i        :   out unsigned(7 downto 0);
        mem_read    :   out std_logic;
        pc_write    :   out std_logic;
        reg_write   :   out std_logic;
        carry_write :   out std_logic;
        ula_op      :   out unsigned(1 downto 0);
        estado      :   out unsigned(1 downto 0)
    );
end entity uc;

architecture a_uc of uc is
    component maq_estados is
        port(
            clk    : IN  std_logic;
            rst    : IN  std_logic;
            estado : out unsigned(1 downto 0)
        );
    end component;
    
    signal estado_s     : unsigned(1 downto 0);
    signal jump_en      : std_logic;
    signal branch_en    : std_logic;
begin
    
    maq_estados0: maq_estados port map(
        clk    => clk,
        rst    => rst,
        estado => estado_s
    );
    
    mem_read    <=  '1' when estado_s="01" else
                    '0';

    pc_write    <=  '1' when estado_s="11" else
                    '0';

    reg_write   <=  '1' when estado_s="10" and (
                            opcode=x"2" or
                            opcode=x"3" or
                            opcode=x"4" or
                            opcode=x"5"
                        ) else
                    '0';

    carry_write <=  '1' when estado_s="10" and (
                            opcode=x"4" or
                            opcode=x"5" or
                            opcode=x"6" or
                            opcode=x"7"
                        ) else
                    '0';

    jump_en     <=  '1' when opcode=x"1" else
                    '0';
    branch_en   <=  '1' when opcode=x"8" and carry='1' else
                    '0';
    
    pc_i    <=  cte         when jump_en='1'    else
                pc_o+1+cte  when branch_en='1'  else
                pc_o+1;

    ula_op  <=  "00" when estado_s="10" and opcode=x"4" else
                "01" when estado_s="10" and opcode=x"5" else
                "10" when estado_s="10" and opcode=x"6" else
                "11" when estado_s="10" and opcode=x"7" else
                "00";

    estado <= estado_s;
end architecture a_uc;