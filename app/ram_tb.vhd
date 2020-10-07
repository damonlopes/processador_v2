LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ram_tb IS
END ENTITY;

ARCHITECTURE a_ram_tb OF ram_tb IS
    COMPONENT ram
        PORT (
            clk : IN std_logic;
            ramwr_en : IN std_logic;
            endereco : IN unsigned (6 DOWNTO 0) := "0000000";
            dadoram_in : IN unsigned (15 DOWNTO 0) := "0000000000000000";
            dadoram_out : OUT unsigned (15 DOWNTO 0) := "0000000000000000"
        );
    END COMPONENT;

    SIGNAL clk, ramwr_en : std_logic;
    SIGNAL endereco : unsigned (6 DOWNTO 0) := "0000000";
    SIGNAL dadoram_in, dadoram_out : unsigned (15 DOWNTO 0) := "0000000000000000";

BEGIN
    uut : ram PORT MAP(
        clk => clk,
        ramwr_en => ramwr_en,
        endereco => endereco,
        dadoram_in => dadoram_in,
        dadoram_out => dadoram_out
    );

    PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 50 ns;
        clk <= '1';
        WAIT FOR 50 ns;
    END PROCESS;

    PROCESS
    BEGIN
        endereco <= "1000001";
        ramwr_en <= '1';
        dadoram_in <= "0111111111111110";
        WAIT FOR 100 ns;

        endereco <= "1001001";
        ramwr_en <= '0';
        dadoram_in <= "1010101010010101";
        WAIT FOR 100 ns;

        endereco <= "0010100";
        ramwr_en <= '0';
        dadoram_in <= "1111111111111111";
        WAIT FOR 100 ns;

        endereco <= "1000001";
        ramwr_en <= '0';
        dadoram_in <= "1010001001001001";
        WAIT FOR 100 ns;

        endereco <= "0000000";
        ramwr_en <= '1';
        dadoram_in <= "1111100000001111";
        WAIT FOR 100 ns;

        endereco <= "1010101";
        ramwr_en <= '1';
        dadoram_in <= "1110010010010111";
        WAIT FOR 100 ns;

        endereco <= "0000000";
        ramwr_en <= '0';
        dadoram_in <= "1100100100101001";
        WAIT FOR 100 ns;

        endereco <= "0000000";
        ramwr_en <= '1';
        dadoram_in <= "1100101111101001";
        WAIT FOR 100 ns;

        WAIT;
    END PROCESS;
END ARCHITECTURE;