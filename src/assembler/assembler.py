import sys 

filename = sys.argv[1]

with open(filename) as f:
    codigo = f.read().split('\n')

opcode_r = {
    'nop':'0000',
    'ld': '0011',
    'add':'0100',
    'sub':'0101',
    'cmp':'0110'
}
opcode_i = {
    'jpa':'0001',
    'ld' :'0010',
    'jrult':'1000'
}

for cod in codigo:
    opcode = cod.split(' ')[0]
    values = cod.split(' ')[-1]
    if ',' in values:
        rd = values.split(',')[0]
        rs = values.split(',')[1]
        sign7 = int(rs) if '$' not in rs else None
        imm7 = None
    else:
        rd = None
        rs = None 
        sign7 = None
        imm7 = int(values)
    

    if sign7 or imm7: #Se tiver alguma constante
        instr = opcode_i[opcode]+'_'
        formato = 'I'
    else:
        instr = opcode_r[opcode]+'_'
        formato = 'R'

    if formato=='I':
        if sign7:
            instr+='000_0_{:08b}'.format(int(sign7))
        elif imm7:
            instr+='000_0_{:08b}'.format(int(imm7))
    elif formato=='R':
        instr+='{:03b}_{:03b}_000000'.format(int(rd[-1]),int(rs[-1]))

    print(instr)