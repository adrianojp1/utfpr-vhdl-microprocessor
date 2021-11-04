library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity regs8x16bits is
    port(
        clk                    : in  STD_LOGIC;
        rst                    : in  STD_LOGIC;
        wr_en                  : in  STD_LOGIC;
        sel_in                 : in  unsigned(2 downto 0);
        sel_out_1, sel_out_2   : in  unsigned(2 downto 0);
        bank_in                : in  unsigned(15 downto 0);
        bank_out_1, bank_out_2 : out unsigned(15 downto 0)
    );
end entity regs8x16bits;

architecture a_regs8x16bits of regs8x16bits is
    component reg16bits is
        port
        (
            clk      : IN STD_LOGIC ;
            rst      : IN STD_LOGIC ;
            wr_en    : IN STD_LOGIC ;
            data_in  : IN unsigned (15 downto 0);
            data_out : OUT unsigned (15 downto 0)
        );
    end component;
    
    signal data_0, data_1, data_2, data_3, data_4, data_5, data_6, data_7: unsigned(15 downto 0);
    signal wr_en_1, wr_en_2, wr_en_3, wr_en_4, wr_en_5, wr_en_6, wr_en_7: STD_LOGIC;
begin

    reg0: reg16bits port map(
        clk => clk, rst => rst, wr_en => '1',
        data_in => "0000000000000000", data_out => data_0
    );
    reg1: reg16bits port map(
        clk => clk, rst => rst, wr_en => wr_en_1,
        data_in => bank_in, data_out => data_1
    );
    reg2: reg16bits port map(
        clk => clk, rst => rst, wr_en => wr_en_2,
        data_in => bank_in, data_out => data_2
    );
    reg3: reg16bits port map(
        clk => clk, rst => rst, wr_en => wr_en_3,
        data_in => bank_in, data_out => data_3
    );
    reg4: reg16bits port map(
        clk => clk, rst => rst, wr_en => wr_en_4,
        data_in => bank_in, data_out => data_4
    );
    reg5: reg16bits port map(
        clk => clk, rst => rst, wr_en => wr_en_5,
        data_in => bank_in, data_out => data_5
    );
    reg6: reg16bits port map(
        clk => clk, rst => rst, wr_en => wr_en_6,
        data_in => bank_in, data_out => data_6
    );
    reg7: reg16bits port map(
        clk => clk, rst => rst, wr_en => wr_en_7,
        data_in => bank_in, data_out => data_7
    );
    
    in_selection: process(sel_in, wr_en)
    begin
        wr_en_1 <= '0';
        wr_en_2 <= '0';
        wr_en_3 <= '0';
        wr_en_4 <= '0';
        wr_en_5 <= '0';
        wr_en_6 <= '0';
        wr_en_7 <= '0';
        
        if wr_en='1' then
            if sel_in="001" then
                wr_en_1 <= '1';
            elsif sel_in="010" then
                wr_en_2 <= '1';
            elsif sel_in="011" then
                wr_en_3 <= '1';
            elsif sel_in="100" then
                wr_en_4 <= '1';
            elsif sel_in="101" then
                wr_en_5 <= '1';
            elsif sel_in="110" then
                wr_en_6 <= '1';
            elsif sel_in="111" then
                wr_en_7 <= '1';
            end if;
        end if;
    end process in_selection;
    
    bank_out_1 <=
    data_0 when sel_out_1="000" else
    data_1 when sel_out_1="001" else
    data_2 when sel_out_1="010" else
    data_3 when sel_out_1="011" else
    data_4 when sel_out_1="100" else
    data_5 when sel_out_1="101" else
    data_6 when sel_out_1="110" else
    data_7 when sel_out_1="111" else
    "0000000000000000";
    
    bank_out_2 <=
    data_0 when sel_out_2="000" else
    data_1 when sel_out_2="001" else
    data_2 when sel_out_2="010" else
    data_3 when sel_out_2="011" else
    data_4 when sel_out_2="100" else
    data_5 when sel_out_2="101" else
    data_6 when sel_out_2="110" else
    data_7 when sel_out_2="111" else
    "0000000000000000";

end architecture a_regs8x16bits;