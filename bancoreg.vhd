library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bancoreg is
    port(
        clk                      : in  STD_LOGIC;
        rst                      : in  STD_LOGIC;
        wr_en                    : in  STD_LOGIC;
        write_reg                : in  unsigned(2 downto 0);
        read_reg_1, read_reg_2   : in  unsigned(2 downto 0);
        write_data               : in  unsigned(15 downto 0);
        read_data_1, read_data_2 : out unsigned(15 downto 0)
    );
end entity bancoreg;

architecture a_bancoreg of bancoreg is
    component registrador is
        port
        (
            clk      : IN  STD_LOGIC ;
            rst      : IN  STD_LOGIC ;
            wr_en    : IN  STD_LOGIC ;
            data_in  : IN  unsigned (15 downto 0);
            data_out : OUT unsigned (15 downto 0)
        );
    end component;
    
    signal data_0, data_1, data_2, data_3, data_4, data_5, data_6, data_7: unsigned(15 downto 0);
    signal wr_en_1, wr_en_2, wr_en_3, wr_en_4, wr_en_5, wr_en_6, wr_en_7: STD_LOGIC;
begin

    reg0: registrador port map(
        clk => clk, rst => rst, wr_en => '1',
        data_in => x"0000", data_out => data_0
    );
    reg1: registrador port map(
        clk => clk, rst => rst, wr_en => wr_en_1,
        data_in => write_data, data_out => data_1
    );
    reg2: registrador port map(
        clk => clk, rst => rst, wr_en => wr_en_2,
        data_in => write_data, data_out => data_2
    );
    reg3: registrador port map(
        clk => clk, rst => rst, wr_en => wr_en_3,
        data_in => write_data, data_out => data_3
    );
    reg4: registrador port map(
        clk => clk, rst => rst, wr_en => wr_en_4,
        data_in => write_data, data_out => data_4
    );
    reg5: registrador port map(
        clk => clk, rst => rst, wr_en => wr_en_5,
        data_in => write_data, data_out => data_5
    );
    reg6: registrador port map(
        clk => clk, rst => rst, wr_en => wr_en_6,
        data_in => write_data, data_out => data_6
    );
    reg7: registrador port map(
        clk => clk, rst => rst, wr_en => wr_en_7,
        data_in => write_data, data_out => data_7
    );
    
    wr_en_1 <= wr_en when write_reg = "001" else '0';
    wr_en_2 <= wr_en when write_reg = "010" else '0';
    wr_en_3 <= wr_en when write_reg = "011" else '0';
    wr_en_4 <= wr_en when write_reg = "100" else '0';
    wr_en_5 <= wr_en when write_reg = "101" else '0';
    wr_en_6 <= wr_en when write_reg = "110" else '0';
    wr_en_7 <= wr_en when write_reg = "111" else '0';

    read_data_1 <=
    data_0 when read_reg_1="000" else
    data_1 when read_reg_1="001" else
    data_2 when read_reg_1="010" else
    data_3 when read_reg_1="011" else
    data_4 when read_reg_1="100" else
    data_5 when read_reg_1="101" else
    data_6 when read_reg_1="110" else
    data_7 when read_reg_1="111" else
    x"0000";
    
    read_data_2 <=
    data_0 when read_reg_2="000" else
    data_1 when read_reg_2="001" else
    data_2 when read_reg_2="010" else
    data_3 when read_reg_2="011" else
    data_4 when read_reg_2="100" else
    data_5 when read_reg_2="101" else
    data_6 when read_reg_2="110" else
    data_7 when read_reg_2="111" else
    x"0000";

end architecture a_bancoreg;