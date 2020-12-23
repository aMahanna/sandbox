LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fiveBitCounter IS
    PORT(
        i_resetBar, i_load    : IN    STD_LOGIC;
        i_clock            : IN    STD_LOGIC;
        o_Value            : OUT    STD_LOGIC_VECTOR(4 downto 0));
END fiveBitCounter;

ARCHITECTURE rtl OF fiveBitCounter IS
    SIGNAL int_a, int_na, int_b, int_nb, int_c, int_nc, int_d, int_nd, int_e, int_ne, int_NCNDNE : STD_LOGIC;
    SIGNAL  int_idA, int_idB, int_idC, int_idD, int_idE: STD_LOGIC;

    COMPONENT enARdFF_2
        PORT(
            i_resetBar    : IN    STD_LOGIC;
            i_d        : IN    STD_LOGIC;
            i_enable    : IN    STD_LOGIC;
            i_clock        : IN    STD_LOGIC;
            o_q, o_qBar    : OUT    STD_LOGIC);
    END COMPONENT;
    
    COMPONENT enARdFF_2INV
        PORT(
            i_resetBar    : IN    STD_LOGIC;
            i_d        : IN    STD_LOGIC;
            i_enable    : IN    STD_LOGIC;
            i_clock        : IN    STD_LOGIC;
            o_q, o_qBar    : OUT    STD_LOGIC);
    END COMPONENT;

BEGIN

    int_NCNDNE <= int_nc OR int_nd OR int_ne;
    -- Concurrent Signal Assignment
    int_idA <= (int_a AND (int_NCNDNE)) OR (int_b AND int_c AND int_d AND int_e);
    int_idB <= (int_b AND (int_NCNDNE)) OR (int_na AND int_nb AND int_c AND int_d AND int_e);
    int_idC <=  (int_c AND int_nd) OR (int_c AND int_ne) OR (int_nc AND int_d AND int_e);
    int_idD <= int_d XOR int_e;
    int_idE <= int_ne;

A: enARdFF_2INV
    PORT MAP (i_resetBar => i_resetBar,
              i_d => int_idA,
              i_enable => i_load, 
              i_clock => i_clock,
              o_q => int_a,
              o_qBar => int_na);

B: enARdFF_2
    PORT MAP (i_resetBar => i_resetBar,
              i_d => int_idB, 
              i_enable => i_load,
              i_clock => i_clock,
              o_q => int_b,
              o_qBar => int_nb);
              
C: enARdFF_2INV
    PORT MAP (i_resetBar => i_resetBar,
              i_d => int_idC, 
              i_enable => i_load,
              i_clock => i_clock,
              o_q => int_c,
              o_qBar => int_nc);
D: enARdFF_2INV
    PORT MAP (i_resetBar => i_resetBar,
              i_d => int_idD,
              i_enable => i_load, 
              i_clock => i_clock,
              o_q => int_d,
              o_qBar => int_nd);

E: enARdFF_2INV
    PORT MAP (i_resetBar => i_resetBar,
              i_d => int_idE, 
              i_enable => i_load,
              i_clock => i_clock,
              o_q => int_e,
              o_qBar => int_ne);
              
              

    -- Output Driver
    o_Value        <= int_a & int_b & int_c & int_d & int_e;

END rtl;
