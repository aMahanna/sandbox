LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY timer IS
    PORT(
        i_resetBar, i_startTimer    : IN    STD_LOGIC;
        i_clock            : IN    STD_LOGIC;
        o_SST, o_MST    : OUT STD_LOGIC);
END timer;

ARCHITECTURE rtl OF timer IS
    SIGNAL int_a, int_na, int_b, int_nb : STD_LOGIC;
    SIGNAL int_idA, int_idB,int_resetBar : STD_LOGIC;

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
    int_idA <= int_a xor int_b;
    int_idB <= int_nb;
    int_resetBar <= i_resetBar AND not(i_startTimer);

msb: enARdFF_2
    PORT MAP (i_resetBar => int_resetBar,
              i_d => int_idA,
              i_enable => '1', 
              i_clock => i_clock,
              o_q => int_a,
              o_qBar => int_na);
lsb: enARdFF_2
    PORT MAP (i_resetBar => int_resetBar,
              i_d => int_idB, 
              i_enable => '1',
              i_clock => i_clock,
              o_q => int_b,
              o_qBar => int_nb);

 -- Output Driver
-- 2 clock cycles for SST
   o_SST   <= int_a and not(int_b);
-- 3 clock cycles for SST
   o_MST <=  int_a and int_b;

END rtl;
