# processador_v2

## Operações
|Opcode|Instrução|Funcionalidade|
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
|1110|Bcond imm7|imm7 + PC -> PC (se cumprir as condições)|
|1111|JMP imm7, reg2|imm7 + GR[reg2] -> PC|
>A instrução de jump (JMP) não foi implementada do mesmo jeito que está descrito no datasheet do processador, contudo a execução dele funciona.

### Tipos de Bcond
- BE (Branch if equal): BBB = 000
  - verifica se flag zero = 1
- BNE (Branch if not equal): BBB = 001
  - verifica se flag zero = 0
- BL (Branch if lower): BBB = 010
  - verifica a flag carry = 1
- BH (Branch if higher): BBB = 100
  - verifica se flag carry = 0

## Formatos OPCODE:
1. Para instruções do tipo ADD/SUB/SUBR/MOV/CMP
```
CCCCIIIIIIIrrrRRR

C - Operação
I - Constante
r - Registrador 1
R - Registrador 2
```

2. Para instruções do tipo Bcond
```
1110IIIIIII00BBBB

I - Constante
B - Tipo de Branch
```
3. Para instruções do tipo JMP
```
1111IIIIIII000000

I - Constante
```
4. Para instrução do tipo NOP
```
00000000000000000
```
## Registradores
|Renesas V850E2S|Registradores desse processador|
|---|---|
|r0|r0|
|r6|r1|
|r7|r2|
|r8|r3|
|r9|r4|
|r10|r5|
|r11|r6|
|r12|r7|

>No Renesas V850E2S, o r2 pode ser também utilizado, mas tem operações do sistema que utilizam o mesmo, então deixamos ele de lado
