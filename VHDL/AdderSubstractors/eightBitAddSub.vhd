LIBRARY IEEE;
use IEEE.std_logic_1164.all;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY eightBitAddSub IS
    PORT(
        SControl        : IN STD_LOGIC;
        i_Ai, i_Bi      : IN    STD_LOGIC_VECTOR(7 downto 0);
        o_Sum            : OUT    STD_LOGIC_VECTOR(7 downto 0);
        o_CarryOut, Overflow, o_ZeroOut : OUT    STD_LOGIC);
END eightBitAddSub;

ARCHITECTURE structure OF eightBitAddSub IS
    COMPONENT oneBitAdder
      PORT(
          i_CarryIn        : IN    STD_LOGIC;
          i_Ai, i_Bi        : IN    STD_LOGIC;
          o_Sum, o_CarryOut    : OUT    STD_LOGIC);
    END COMPONENT;
    
    SIGNAL C1, C2, C3, C4, C5, C6, C7, C8: STD_LOGIC;
    SIGNAL Y: STD_LOGIC_VECTOR(7 downto 0);
    
    SIGNAL int_Sum : STD_LOGIC_VECTOR(7 downto 0);

BEGIN

    -- Concurrent Signal Assignment
    Y(0) <= SControl XOR i_Bi(0);
    Y(1) <= SControl XOR i_Bi(1);
    Y(2) <= SControl XOR i_Bi(2);
    Y(3) <= SControl XOR i_Bi(3);
    Y(4) <= SControl XOR i_Bi(4);
    Y(5) <= SControl XOR i_Bi(5);
    Y(6) <= SControl XOR i_Bi(6);
    Y(7) <= SControl XOR i_Bi(7);
    
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

addSub4: oneBitAdder
    PORT MAP (i_CarryIn => C4, 
              i_Ai => i_Ai(4),
              i_Bi => Y(4),
              o_Sum => int_Sum(4),
              o_CarryOut => C5);

addSub5: oneBitAdder
    PORT MAP (i_CarryIn => C5, 
              i_Ai => i_Ai(5),
              i_Bi => Y(5),
              o_Sum => int_Sum(5),
              o_CarryOut => C6);

addSub6: oneBitAdder
    PORT MAP (i_CarryIn => C6, 
              i_Ai => i_Ai(6),
              i_Bi => Y(6),
              o_Sum => int_Sum(6),
              o_CarryOut => C7);

addSub7: oneBitAdder
    PORT MAP (i_CarryIn => C7, 
              i_Ai => i_Ai(7),
              i_Bi => Y(7),
              o_Sum => int_Sum(7),
              o_CarryOut => C8);

    -- Output Driver
    Overflow <= C7 XOR C8;
    o_CarryOut <= C8;
    o_Sum <= int_Sum;
    o_zeroOut <= not(int_Sum(7) OR int_Sum(6) OR int_Sum(5) OR
    int_Sum(4)OR int_Sum(3) OR int_Sum(2) OR int_Sum(1) OR
    int_Sum(0));

END structure;