LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fourByOneMultiplexer IS
	PORT(
		i_s0, i_s1		: IN	STD_LOGIC;
		i_d0, i_d1, i_d2, i_d3	: IN	STD_LOGIC_VECTOR(7 downto 0);
		o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0));
END fourByOneMultiplexer;

ARCHITECTURE rtl OF fourByOneMultiplexer IS
	SIGNAL int_ValueOut	: STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL int_s1s0 : STD_LOGIC_VECTOR(1 downto 0);
BEGIN
	-- Concurrent Signal Assignment
int_s1s0   <=  i_s1 & i_s0;
int_ValueOut <= i_d0 when int_s1s0="00"  else
 	   	     	    i_d1 when int_s1s0="01"  else
 	   	     	    i_d2 when int_s1s0="10"  else
 	   	     	    i_d3;

-- Output Driver
o_Value <= int_ValueOut;

END rtl;
