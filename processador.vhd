library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
    port(
        rst         :   in  std_logic;
        clk         :   in  std_logic;
        estado      :   out unsigned(1 downto 0);
        pc_out      :   out unsigned(7 downto 0);
        instr       :   out unsigned(15 downto 0); -- saída do registrador de instrução
        reg1        :   out unsigned(15 downto 0); -- saída 1 do banco de registradores
        reg2        :   out unsigned(15 downto 0); -- saída 2 do banco de registradores
        main_out    :   out unsigned(15 downto 0)
    );
end entity processador;

architecture a_processador of processador is
    component uc is
        port(
            clk         :   in  std_logic;
            rst         :   in  std_logic;
            opcode      :   in  unsigned(3 downto 0);
            cte         :   in  unsigned(7 downto 0);
            carry       :   in  std_logic;
            pc_o        :   in  unsigned(7 downto 0);
            pc_i        :   out unsigned(7 downto 0);
            rom_read    :   out std_logic;
            ram_write   :   out std_logic;
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

    component rom is 
        port(
            clk         : in  std_logic;
            endereco    : in  unsigned(7 downto 0);
            mem_data    : out unsigned(15 downto 0)
        );
    end component;

    component registrador is
        port(
            clk         :   in  std_logic;
            rst         :   in  std_logic;
            wr_en       :   in  std_logic;
            data_in     :   in  unsigned(15 downto 0);
            data_out    :   out unsigned(15 downto 0)
        );
    end component;
    
    component bancoreg is
        port(
            clk         : in  std_logic;
            rst         : in  std_logic;
            wr_en       : in  std_logic;
            write_reg   : in  unsigned(2 downto 0);
            read_reg_1  : in  unsigned(2 downto 0);
            read_reg_2  : in  unsigned(2 downto 0);
            write_data  : in  unsigned(15 downto 0);
            read_data_1 : out unsigned(15 downto 0);
            read_data_2 : out unsigned(15 downto 0)
        );
    end component;

    component ula is
        port(
            in_x, in_y  : in  unsigned(15 downto 0);
            sel_op      : in  unsigned(1  downto 0);
            saida       : out unsigned(15 downto 0);
            carry       : out std_logic
        );
    end component;

    component registrador_flag is
        port(
            clk         :   in  std_logic;
            rst         :   in  std_logic;
            wr_en       :   in  std_logic;
            data_in     :   in  std_logic;
            data_out    :   out std_logic
        );
    end component;

    component ram is
        port(
            clk         :   in std_logic;
            wr_en       :   in std_logic;
            endereco    :   in unsigned(7 downto 0);
            dado_in     :   in unsigned(15 downto 0);
            dado_out    :   out unsigned(15 downto 0)
        );
    end component ram;
    
    signal opcode           : unsigned(3 downto 0);
    signal cte              : unsigned(7 downto 0);
    signal rd               : unsigned(2 downto 0);
    signal rs               : unsigned(2 downto 0);
    signal pc_o             : unsigned(7 downto 0);
    signal pc_i             : unsigned(7 downto 0);

    signal rom_read         : std_logic;
    signal ram_write        : std_logic;
    signal pc_write         : std_logic;
    signal reg_write        : std_logic;
    signal carry_write      : std_logic;
    signal ula_op           : unsigned(1 downto 0);

    signal mem_data         : unsigned(15 downto 0);
    signal instr_s          : unsigned(15 downto 0);

    signal reg_write_data   : unsigned(15 downto 0);
    signal read_reg_1       : unsigned(2 downto 0);
    signal read_reg_2       : unsigned(2 downto 0);
    signal read_data_1      : unsigned(15 downto 0);
    signal read_data_2      : unsigned(15 downto 0);

    signal ula_src_a        : unsigned(15 downto 0);
    signal ula_src_b        : unsigned(15 downto 0);
    signal ula_out_s        : unsigned(15 downto 0);
    signal ula_carry        : std_logic;

    signal carry            : std_logic;

    signal ram_endereco     : unsigned(7 downto 0);
    signal ram_write_data   : unsigned(15 downto 0);
    signal ram_read_data    : unsigned(15 downto 0);
begin

    uc0: uc port map(
        clk         =>  clk,
        rst         =>  rst,
        opcode      =>  opcode,
        cte         =>  cte,
        carry       =>  carry,
        pc_o        =>  pc_o,
        pc_i        =>  pc_i,
        rom_read    =>  rom_read,
        ram_write   =>  ram_write,
        pc_write    =>  pc_write,
        reg_write   =>  reg_write,
        carry_write =>  carry_write,
        ula_op      =>  ula_op,
        estado      =>  estado
    );

    pc0: pc port map(
        clk         =>  clk,
        rst         =>  rst,
        wr_en       =>  pc_write,
        endereco_i  =>  pc_i,
        endereco_o  =>  pc_o
    );

    rom0: rom port map(
        clk         =>  clk,
        endereco    =>  pc_o,
        mem_data    =>  mem_data
    );

    instr_reg: registrador port map(
        clk         =>  clk,
        rst         =>  rst,
        wr_en       =>  rom_read,
        data_in     =>  mem_data,
        data_out    =>  instr_s
    );

    bancoreg0: bancoreg port map(
        clk         =>  clk,
        rst         =>  rst,
        wr_en       =>  reg_write,
        write_reg   =>  rd,
        write_data  =>  reg_write_data,
        read_reg_1  =>  read_reg_1,
        read_reg_2  =>  read_reg_2,
        read_data_1 =>  read_data_1,
        read_data_2 =>  read_data_2
    );

    ula0: ula port map(
        in_x        =>  ula_src_a,
        in_y        =>  ula_src_b,
        sel_op      =>  ula_op,
        saida       =>  ula_out_s,
        carry       =>  ula_carry
    );

    carry_reg: registrador_flag port map(
        clk         => clk,
        rst         => rst,
        wr_en       => carry_write,
        data_in     => ula_carry,
        data_out    => carry
    );

    ram0: ram port map(
        clk         =>  clk,
        wr_en       =>  ram_write,
        endereco    =>  ram_endereco,
        dado_in     =>  ram_write_data,
        dado_out    =>  ram_read_data
    );

    opcode <= instr_s(15 downto 12);
    rd     <= instr_s(11 downto 9);
    rs     <= instr_s(8  downto 6);
    cte    <= instr_s(7  downto 0);

    reg_write_data  <=  ram_read_data when opcode=x"9" else
                        ula_out_s;

    read_reg_1      <=  "000" when (opcode=x"3" or opcode=x"2") else
                        rd;
    read_reg_2      <=  rs;

    ula_src_a       <=  read_data_1;
    ula_src_b       <=  (7 downto 0 => cte(7)) & cte when opcode=x"2" else
                        read_data_2;

    ram_endereco    <=  read_data_2(7  downto 0);
    ram_write_data  <=  read_data_1;
    
    pc_out          <=  pc_o;
    instr           <=  instr_s;
    reg1            <=  read_data_1;
    reg2            <=  read_data_2;
    main_out        <=  ram_read_data;

end architecture a_processador;