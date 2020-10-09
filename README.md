# Renesas V850E2S (CSW30)

## Operações
|Código(MSB)|Instrução|Funcionalidade|
|---|---|---|
|0000|NOP||
|0001|???||
|0010|ADD imm7, reg2|GR[reg2] + imm7 -> GR[reg2]|
|0011|ADD imm7, reg2|GR[reg2] + GR[reg1] -> GR[reg2]|
|0100|SUB reg1, reg2|GR[reg2] - GR[reg1] -> GR[reg2]|
|0101|SUBR reg1, reg2|GR[reg1] - GR[reg2] -> GR[reg1]|
|0110|MOV imm7, reg2|imm7 -> GR[reg2]|
|0111|MOV reg1, reg2|GR[reg1] -> GR[reg2]|
|1000|CMP imm7, reg2|GR[reg2] - imm7 -> result|
|1001|CMP reg1, reg2|GR[reg2] - GR[reg1] -> result|
|1010|LD.W disp7[reg1], reg2|1- GR[reg1] + sign-extend(disp7) -> addr/2- loadmem(addr,Word) -> GR[reg2]|
|1011|ST.W reg2, disp7[reg1]|1- GR[reg1] + sign-extend(disp7) -> addr/2- storemem(addr,GR[reg2],Word)|
|1110|Bcond imm7|imm7 + PC -> PC (se cumprir as condições)|
|1111|JMP imm7, reg2|imm7 + GR[reg2] -> PC|
>A instrução de jump (JMP) não foi implementada do mesmo jeito que está descrito no datasheet do processador

## Formatos OPCODE:
1. NOP
```
00000000000000000
```
2. ADD imm7, reg2
```
0010iiiiiii000RRR

i - Constante (imm7)
R - Registrador 2 (reg2)
```
3. ADD reg1, reg2
```
00110000000rrrRRR

r - Registrador 1 (reg1)
R - Registrador 2 (reg2)

```
4. SUB reg1, reg2
```
01000000000rrrRRR

r - Registrador 1 (reg1)
R - Registrador 2 (reg2)
```
5. SUBR reg1, reg2
```
01010000000RRRrrr

r - Registrador 1 (reg1)
R - Registrador 2 (reg2)
```
6. MOV imm7, reg2
```
0110iiiiiii000RRR

i - Constante (imm7)
R - Registrador 2 (reg2)
```
7. MOV reg1, reg2
```
01110000000rrrRRR

r - Registrador 1 (reg1)
R - Registrador 2 (reg2)
```
8. CMP imm7, reg2
```
1000iiiiiii000RRR

i - Constante (imm7)
R - Registrador 2 (reg2)
```
9. CMP reg1, reg2
```
10010000000rrrRRR

r - Registrador 1 (reg1)
R - Registrador 2 (reg2)
```
10. LD.W disp7[reg1], reg2
```
1010iiiiiiirrrRRR

i - Constante (disp7)
r - Registrador 1 (reg1)
R - Registrador 2 (reg2)
```
11. ST.W reg2, disp7[reg1]
```
1011iiiiiiirrrRRR

i - Constante (disp7)
r - Registrador 1 (reg1)
R - Registrador 2 (reg2)
```
12. Bcond disp7
```
1110iiiiiii000bbb

i - Constante (disp7)
b - Condição do Branch
```
#### Tipos de condições
- BE (Branch if equal): bbb = 000
  - verifica se flag zero = 1
- BNE (Branch if not equal): bbb = 001
  - verifica se flag zero = 0
- BL (Branch if lower): bbb = 010
  - verifica a flag carry = 1
- BNL (Branch if not lower): bbb = 011
  - verifica se flag carry = 0
- BN (Branch if negative): bbb = 100
  - verifica se flag negativo = 1
- BP (Branch if positive): bbb = 101
  - verifica se flag negativo = 0
13. JMP disp7[reg1]
```
1111iiiiiiirrr000

i - Constante (disp7)
r - Registrador 1 (reg1) = 000*
```
>Como não foi implementado 100% igual, para facilitar a operação de jump, o reg1 fica setado para o r0, fazendo com que somente o disp7 seja efetivamente o tamanho do desvio

## Registradores
|Renesas V850E2S|Registradores desse processador|
|---|---|
|r0|r0 (000)|
|r6|r1 (001)|
|r7|r2 (010)|
|r8|r3 (011)|
|r9|r4 (100)|
|r10|r5 (101)|
|r11|r6 (110)|
|r12|r7 (111)|

>No Renesas V850E2S, o r2 pode ser também utilizado, mas tem operações do sistema que utilizam o mesmo, então deixamos ele de lado
