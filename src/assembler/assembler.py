import sys

filename = sys.argv[1]

with open(filename) as f:
    codigo = f.read().split('\n')

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


def to_instr(cod):
    if cod.strip() == "":
        return '0000_0000_00000000'

    opcode, values = cod.split(' ')

    if ',' in values:
        rd = get_reg_bin(values.split(',')[0])
        last = values.split(',')[-1]

        if '$' in last:
            rs = get_reg_bin(last)
            const = None

        else:
            rs = None
            const = last

    else:
        rd = '000'
        rs = None
        const = values

    if rs:  # Se tiver o segundo reg
        instr = opcode_r[opcode]+'_'
        formato = 'R'

    else:
        instr = opcode_i[opcode]+'_'
        formato = 'I'

    if formato == 'I':
        const_bin = get_const_bin(const)
        instr += f'{rd}_0_{const_bin}'

    elif formato == 'R':
        instr += f'{rd}_{rs}_000000'

    return instr


intructions = [to_instr(cod) for cod in codigo]

print('Binary:')
for instr in intructions:
    print(instr)

print('\nVHDL:')
for i, instr in enumerate(intructions):
    i = str(i) + ' ' if i < 10 else i
    print(f'{i} => B"{instr}",')
