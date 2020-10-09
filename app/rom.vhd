LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rom IS
	PORT (
		clk : IN std_logic; -- Clock da ROM
		endereco : IN unsigned(6 DOWNTO 0) := "0000000"; -- Endereço da ROM
		dado : OUT unsigned(16 DOWNTO 0) := "00000000000000000" -- Instrução correspondente ao endereço na ROM
	);
END ENTITY;

ARCHITECTURE a_rom OF rom IS
	TYPE mem IS ARRAY (0 TO 127) OF unsigned (16 DOWNTO 0); -- De acordo com qual endereço estiver, ele vai mandar um valor
	CONSTANT conteudo_rom : mem := (-- para a saída da ROM, que vai para a UC e para os outros lugares do processador
	0 => "01100000101000001", --				MOV 5,  R6 		    0x0C141
	1 => "01100001010000010", -- 				MOV 10, R7   		0x0C282
	2 => "10110000001011010", -- 				ST.W 1[R8], R7      0x1605A
	3 => "10110000000011001", -- 				ST.W 0[R8], R6      0x16019
	4 => "10100000000111011", --				LD.W R8, 0[R12]     0x1403B
	5 => "10100000001111100", --				LD.W R9, 1[R11]		0x1407C
	6 => "00100000001000011", --				ADD 1, R8			0x04043
	7 => "00110000000011100", --                ADD R8, R9			0x0601C
	8 => "10110000010000100", --				ST.W 2[R0], R9		0x16084
	9 => "10110000011000011", --				ST.W 3[R0], R8		0x160C3

	OTHERS => (OTHERS => '0')
	); -- (r6 = 001(r1), r7 = 010(r2) e por assim vai)

	SIGNAL valor : unsigned(16 DOWNTO 0) := "00000000000000000";
	SIGNAL operacao : unsigned(3 DOWNTO 0) := "0000";
	SIGNAL constante : unsigned(6 DOWNTO 0) := "0000000";
	SIGNAL reg1, reg2 : unsigned(2 DOWNTO 0) := "000";

BEGIN
	PROCESS (clk)
	BEGIN
		IF (rising_edge(clk)) THEN
			dado <= conteudo_rom(to_integer(endereco));
			valor <= conteudo_rom(to_integer(endereco));
		END IF;
		operacao <= valor(16 DOWNTO 13); -- Porta interna para checar qual instrução é
		constante <= valor(12 DOWNTO 6); -- Porta interna para checar o valor da constante
		reg1 <= valor(5 DOWNTO 3); -- Porta interna para checar o registrador 1 (conectado na MUX)
		reg2 <= valor(2 DOWNTO 0); -- Porta interna para chegar o registrador 2 (conectado diretamente na ULA)
	END PROCESS;
END ARCHITECTURE;
