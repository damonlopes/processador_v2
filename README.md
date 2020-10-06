# processador_v2

Operações
0000 - NOP\
0001 - ???\
0010 - ADD  imm7, reg2 (GR[reg2] + imm7 -> GR[reg2])\
0011 - ADD  reg1, reg2 (GR[reg2] + GR[reg1] -> GR[reg2])\
0100 - SUB  reg1, reg2 (GR[reg2] - GR[reg1] -> GR[reg2])\
0101 - SUBR reg1, reg2 (GR[reg1] - GR[reg2] -> GR[reg1])\
0110 - MOV  imm7, reg2 (imm7 -> GR[reg2])\
0111 - MOV  reg1, reg2 (GR[reg1] -> GR[reg2])\
1000 - CMP  imm7, reg2 (GR[reg2] - imm7 -> result)\
1001 - CMP  reg1, reg2 (GR[reg2] - GR[reg1] -> result)\
1110 - Bcond imm7 (imm7 + PC -> PC se cumprir as condições)\
    tipos de Bcond\
        BE (Branch if equal): BBB = 000\
            verifica se flag zero = 1\
        BNE (Branch if not equal): BBB = 001\
            verifica se flag zero = 0\
        BL (Branch if lower): BBB = 010\
            verifica a flag carry = 1\
        BH (Branch if higher): BBB = 100\
            verifica se flag carry = 0\
1111 - JMP  imm7, reg1 (imm7 + GR[reg1] -> PC)*\

*a instrução de jump (JMP) não foi implementada do mesmo jeito que está descrito no datasheet do processador,
 contudo a execução dele funciona.

Formatos OPCODE:
1 - Para instruções do tipo ADD/SUB/SUBR/MOV/CMP

    CCCCIIIIIIIrrrRRR

    C - Operação
    I - Constante
    r - Registrador 1
    R - Registrador 2

2 - Para instruções do tipo Bcond

    1110IIIIIII00BBBB

    I - Constante
    B - Tipo de Branch

3 - Para instruções do tipo JMP

    1111IIIIIII000000

    I - Constante

4 - Para instrução do tipo NOP

    00000000000000000

Registradores
r6     /r7     /r8     /r9     /r10     /r11     /r12      - Registradores do processador (V850E2S)
r1(001)/r2(010)/r3(011)/r4(100)/r5(101) /r6(110) /r7(111)  - Registradores reais do nosso processador

Instruções
0  - MOV 0, R8             -- Armazena 0 no R3 
1  - MOV 0, R9             -- Armazena 0 no R4
2  - MOV 30, R11           -- Armazena 30 no R6 (pra comparação)
3  - ADD R8, R9            -- Soma R3 com R4 e guarda em R4
4  - ADD 1, R8             -- Soma 1 com R3 e guarda em R3
5  - BL 4, R8, R11         -- Compara se R3 < 30, se sim volta para o endereço 4
6  - MOV R9, R10           -- Armazena o valor de R4 em R5

Opcodes 
0  - 01100000000000011          -- 0x0C003
1  - 01100000000000100		-- 0x0C004
2  - 01100011110000110		-- 0x0C786
3  - 00110000000011100		-- 0x0601C
4  - 00100000001000011		-- 0x04043
5  - 10101111110011110		-- 0x15F9E
6  - 01110000000100101 		-- 0x0E025
