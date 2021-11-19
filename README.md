--- README não formatado ---

[Cópia do estudo preliminar]
Instruções originais do processador a implementar para operações de:
- Carga de constante:                   ld %rd,sign7
- Cópia de valor entre registradores:   ld %rd,%rs
- Soma de dois valores:                 add %rd,%rs
- Subtração de dois valores:            sub %rd,%rs
- Desvio incondicional:                 jpa imm7

Instruções (segundo o lab #5) + opcodes
- nop:                                          x0
- salto incondicional:                          x1
- carga de constantes:                          x2
- transferência de valores entre registradores: x3
- soma entre registradores:                     x4
- subtração entre registradores:                x5
- comp. maior:                                  x6
- impar:                                        x7

Codificação Opcode:
Formato I (operações com constantes):
opcode[15:12] rd[11:9] cte[7:0]

Formato R (operações entre registradores):
opcode[15:12] rd[11:9] rs[8:6]

Código lab 5:
1. Carrega R3 (o registrador 3) com o valor 5
2. Carrega R4 com 8
3. Soma R3 com R4 e guarda em R5
4. Subtrai 1 de R5
5. Salta para o endereço 20
6. No endereço 20, copia R5 para R3
7. Salta para a terceira instrução desta lista (R5 <= R3+R4)

1. ld $R3,5
2. ld $R4,8
3. ld $R5,$R3
4. add $R5,$R4
5. ld $R1,1
6. sub $R5,$R1
7. jpa 20
20. ld $R3,$R5
21. jpa 3