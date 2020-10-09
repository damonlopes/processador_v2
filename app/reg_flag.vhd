LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY reg_flag IS
    PORT (
        clk : IN std_logic;
        rst : IN std_logic;
        flagwr_en : IN std_logic;
        flagcarry_in : IN std_logic;
        flagzero_in : IN std_logic;
        flagneg_in : IN std_logic;
        sel_branch : IN unsigned (2 DOWNTO 0) := "000";

        flag_out : OUT std_logic
    );
END ENTITY;

ARCHITECTURE a_reg_flag OF reg_flag IS
    SIGNAL flagcarry_mem, flagzero_mem, flagneg_mem : std_logic;

BEGIN

    PROCESS (clk, rst, flagwr_en, sel_branch, flagcarry_mem, flagzero_mem)
    BEGIN

        IF rst = '1' THEN
            flagcarry_mem <= '0';
            flagzero_mem <= '0';
            flagneg_mem <= '0';
            flag_out <= '0';
        ELSIF flagwr_en = '1' THEN
            IF rising_edge(clk) THEN
                flagcarry_mem <= flagcarry_in;
                flagzero_mem <= flagzero_in;
                flagneg_mem <= flagneg_in;
                flag_out <= '0';
            END IF;
        END IF;

        IF sel_branch = "000" THEN -- BE
            flag_out <= flagzero_mem;
        ELSIF sel_branch = "001" THEN -- BNE
            flag_out <= NOT flagzero_mem;
        ELSIF sel_branch = "010" THEN -- BL
            flag_out <= flagcarry_mem;
        ELSIF sel_branch = "011" THEN -- BH
            flag_out <= NOT flagcarry_mem;
        ELSIF sel_branch <= "100" THEN -- BN
            flag_out <= flagneg_mem;
        ELSIF sel_branch <= "101" THEN -- BP
            flag_out <= NOT flagneg_mem;
        END IF;

    END PROCESS;

END ARCHITECTURE;