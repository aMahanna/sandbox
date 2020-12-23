LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY threeBitCounter IS
    PORT(
        i_resetBar, i_load    : IN    STD_LOGIC;
        i_clock, i_resetCounter           : IN    STD_LOGIC;
        SixBytes  : OUT STD_LOGIC);
END threeBitCounter;

ARCHITECTURE rtl OF threeBitCounter IS
    SIGNAL int_a, int_na, int_b, int_nb, int_c, int_nc, int_naORne, int_resetBar : STD_LOGIC;
    SIGNAL  int_idA, int_idB, int_idC: STD_LOGIC;

    COMPONENT enARdFF_2
        PORT(
            i_resetBar    : IN    STD_LOGIC;
            i_d        : IN    STD_LOGIC;
            i_enable    : IN    STD_LOGIC;
            i_clock        : IN    STD_LOGIC;
            o_q, o_qBar    : OUT    STD_LOGIC);
    END COMPONENT;


BEGIN

    -- Concurrent Signal Assignment
    int_idA <= (int_a AND int_nb) OR (int_a AND int_nc) OR (int_na AND int_b and int_c);
    int_idB <= int_b XOR int_c;
    int_idC <= int_nc;
    int_resetBar <= i_resetBar AND not(i_resetCounter);

msb: enARdFF_2
    PORT MAP (i_resetBar => int_resetBar,
              i_d => int_idA,
              i_enable => i_load, 
              i_clock => i_clock,
              o_q => int_a,
              o_qBar => int_na);

mb: enARdFF_2
    PORT MAP (i_resetBar => int_resetBar,
              i_d => int_idB, 
              i_enable => i_load,
              i_clock => i_clock,
              o_q => int_b,
              o_qBar => int_nb);
              
lsb: enARdFF_2
    PORT MAP (i_resetBar => int_resetBar,
              i_d => int_idC, 
              i_enable => i_load,
              i_clock => i_clock,
              o_q => int_c,
              o_qBar => int_nc);
              

    -- Output Driver
    SixBytes <= int_a and not(int_b) and int_c;

END rtl;


