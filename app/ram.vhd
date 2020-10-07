LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ram IS
    PORT (
        clk : IN std_logic;
        ramwr_en : IN std_logic;
        endereco : IN unsigned (6 DOWNTO 0) := "0000000";
        dadoram_in : IN unsigned (15 DOWNTO 0) := "0000000000000000";
        dadoram_out : OUT unsigned (15 DOWNTO 0) := "0000000000000000"
    );
END ENTITY;

ARCHITECTURE a_ram OF ram IS
    TYPE mem IS ARRAY (0 TO 127) OF unsigned(15 DOWNTO 0);
    SIGNAL conteudo_ram : mem;

BEGIN
    PROCESS (clk, ramwr_en)
    BEGIN
        IF rising_edge(clk) THEN
            IF (ramwr_en = '1') THEN
                conteudo_ram(to_integer(endereco)) <= dadoram_in;
            END IF;
        END IF;
    END PROCESS;
    dadoram_out <= conteudo_ram(to_integer(endereco));

END ARCHITECTURE;