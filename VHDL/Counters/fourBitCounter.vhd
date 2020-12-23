LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY counterlab4 IS
    PORT(
        i_resetBar, i_load    : IN    STD_LOGIC;
        i_clock            : IN    STD_LOGIC;
        o_count9            : OUT    STD_LOGIC);
END counterlab4;

ARCHITECTURE rtl OF counterlab4 IS
    SIGNAL int_a, int_na, int_b, int_nb, int_c, int_nc, int_d, int_nd : STD_LOGIC;
    SIGNAL  int_idA, int_idB, int_idC, int_idD: STD_LOGIC;

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
    int_idA <= (int_a AND int_nd) OR (int_b AND int_c and int_d);
    int_idB <= (int_b AND int_nc) OR (int_b AND int_nd) OR (int_nb AND int_c AND int_d);
    int_idC <= (int_c AND int_nd) OR (int_na AND int_nc AND int_d);
	 int_idD <= int_nd;

A: enARdFF_2
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
              
C: enARdFF_2
    PORT MAP (i_resetBar => i_resetBar,
              i_d => int_idC, 
              i_enable => i_load,
              i_clock => i_clock,
              o_q => int_c,
              o_qBar => int_nc);
				  
D: enARdFF_2
    PORT MAP (i_resetBar => i_resetBar,
              i_d => int_idD, 
              i_enable => i_load,
              i_clock => i_clock,
              o_q => int_d,
              o_qBar => int_nd);

              

    -- Output Driver
    o_count9 <= int_a and int_nb and int_nc and int_d;

END rtl;
