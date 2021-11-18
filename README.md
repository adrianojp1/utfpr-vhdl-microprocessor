--- README não formatado ---
Done:
 - maq_estados + tb
 - pc + tb
 - ula + tb
 - rom + tb
 - banco_reg + tb
 - reg + tb

TODO:
 - (WIP) uc + tb 
 - top_level + tb (renomear para processador)
 - remover processador.vhd + tb


[Cópia do estudo preliminar]
Instruções originais do processador a implementar para operações de:
- Carga de constante: ld %rd,sign7
- Cópia de valor entre registradores: ld %rd,%rs
- Soma de dois valores: add %rd,%rs
- Subtração de dois valores: sub %rd,%rs
- Desvio incondicional: jpa imm7

Instruções (segundo o lab #5) + opcodes
- nop: x0
- salto incondicional: x1
- carga de constantes: x2
- transferência de valores entre registradores: x3
- soma entre registradores: x4
- subtração entre registradores: x5
- comp. maior: x6
- impar: x7

Codificação Opcode:
Formato I (operações com constantes):
opcode[15:12] rd[11:9] cte[6:0]

Formato R (operações entre registradores):
opcode[15:12] rd[11:9] rs[8:6]