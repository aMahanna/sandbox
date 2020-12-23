LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY oneBitAdder IS
    PORT(
        i_CarryIn        : IN    STD_LOGIC;
        i_Ai, i_Bi        : IN    STD_LOGIC;
        o_Sum, o_CarryOut    : OUT    STD_LOGIC);
END oneBitAdder;

ARCHITECTURE rtl OF oneBitAdder IS
    SIGNAL int_CarryOut1, int_CarryOut2, int_CarryOut3: STD_LOGIC;

BEGIN

    -- Concurrent Signal Assignment
    int_CarryOut1 <= i_Ai xor i_Bi;
    int_CarryOut2 <= i_Ai and i_Bi;
    int_CarryOut3 <= i_CarryIn and int_CarryOut1;

    -- Output Driver
    o_CarryOut <= int_CarryOut2 or int_CarryOut3;
    o_Sum <= i_CarryIn xor i_Ai xor i_Bi;

END rtl;
