LIBRARY IEEE;
use IEEE.std_logic_1164.all;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fourBitAddSub IS
    PORT(
        SControl        : IN STD_LOGIC;
        i_Ai, i_Bi        : IN    STD_LOGIC_VECTOR(3 downto 0);
        o_Sum            : OUT    STD_LOGIC_VECTOR(7 downto 0);
        o_CarryOut, Overflow, o_ZeroOut : OUT    STD_LOGIC);
END fourBitAddSub;

ARCHITECTURE structure OF fourBitAddSub IS
    COMPONENT oneBitAdder
      PORT(
          i_CarryIn        : IN    STD_LOGIC;
          i_Ai, i_Bi        : IN    STD_LOGIC;
          o_Sum, o_CarryOut    : OUT    STD_LOGIC);
    END COMPONENT;
    
    SIGNAL C1, C2, C3, C4: STD_LOGIC;
    SIGNAL Y: STD_LOGIC_VECTOR(3 downto 0);
    
    SIGNAL int_Sum : STD_LOGIC_VECTOR(3 downto 0);

BEGIN

    -- Concurrent Signal Assignment
    Y(0) <= SControl XOR i_Bi(0);
    Y(1) <= SControl XOR i_Bi(1);
    Y(2) <= SControl XOR i_Bi(2);
    Y(3) <= SControl XOR i_Bi(3);
    
addSub0: oneBitAdder
    PORT MAP (i_CarryIn => SControl, 
              i_Ai => i_Ai(0),
              i_Bi => Y(0),
              o_Sum => int_Sum(0),
              o_CarryOut => C1);

addSub1: oneBitAdder
    PORT MAP (i_CarryIn => C1, 
              i_Ai => i_Ai(1),
              i_Bi => Y(1),
              o_Sum => int_Sum(1),
              o_CarryOut => C2);

addSub2: oneBitAdder
    PORT MAP (i_CarryIn => C2, 
              i_Ai => i_Ai(2),
              i_Bi => Y(2),
              o_Sum => int_Sum(2),
              o_CarryOut => C3);

addSub3: oneBitAdder
    PORT MAP (i_CarryIn => C3, 
              i_Ai => i_Ai(3),
              i_Bi => Y(3),
              o_Sum => int_Sum(3),
              o_CarryOut => C4);

    -- Output Driver
    Overflow <= C3 XOR C4;
    o_CarryOut <= C4;
    o_Sum <= "0000" & int_Sum;
    o_zeroOut <= not(int_Sum(3) OR int_Sum(2) OR int_Sum(1) OR
    int_Sum(0));

END structure;
