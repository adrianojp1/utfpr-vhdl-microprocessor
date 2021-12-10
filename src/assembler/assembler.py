import sys

filename = sys.argv[1]

with open(filename) as f:
    codigo = f.read().split('\n')

opcode_mem_read = '1001'
opcode_mem_write = '1010'
opcode_r = {
    'nop': '0000',
    'ld': '0011',
    'add': '0100',
    'sub': '0101',
    'cmp': '0110'
}
opcode_i = {
    'jpa': '0001',
    'ld': '0010',
    'jrult': '1000'
}


def get_reg_bin(reg: str) -> str:
    reg_int = int(reg[-1])
    return format(reg_int, '03b')


def get_const_bin(const: str) -> str:
    const_int = int(const)
    return format(const_int if const_int >= 0 else (1 << 8) + const_int, '08b')


def to_instr(cod: str):
    cod = cod.strip()

    if cod[:2] == "//" or cod == "":
        return None

    if cod[:3] == "nop":
        return '0000_0000_00000000'

    rb = None
    rd = None
    rs = None
    const = None

    opcode, values = cod.split(' ')

    if ',' in values:
        first, second = values.split(',')
        if '[' in first:
            rb = get_reg_bin(first[1:-1])
            rs = get_reg_bin(second)

        elif '[' in second:
            rd = get_reg_bin(first)
            rb = get_reg_bin(second[1:-1])

        else:
            rd = get_reg_bin(first)
            if '%' in second:
                rs = get_reg_bin(second)
            else:
                const = second
    else:
        rd = '000'
        const = values


    if rd and rb: # Carga de memória para registrador
        instr = f'{opcode_mem_read}_{rd}_{rb}_000000'

    elif rb and rs: # Carga de registrador para memória
        instr = f'{opcode_mem_write}_{rs}_{rb}_000000'

    elif rd and rs: # Operações com dois registradores
        instr = f'{opcode_r[opcode]}_{rd}_{rs}_000000'

    else: # Operações com constante
        const_bin = get_const_bin(const)
        instr = f'{opcode_i[opcode]}_{rd}_0_{const_bin}'

    return instr


instructions = []
n=0
for cod in codigo:
    instruction = to_instr(cod)
    if instruction is not None:
        print(n,"=>",cod.strip())
        n+=1
        instructions.append(instruction)

print('Binary:')
for instr in instructions:
    print(instr)

print('\nVHDL:')
for i, instr in enumerate(instructions):
    i = str(i) + ' ' if i < 10 else i
    print(f'{i} => B"{instr}",')
