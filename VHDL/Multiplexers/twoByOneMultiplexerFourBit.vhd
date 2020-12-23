LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Multiplexer IS
	PORT(
		i_d0, i_d1	: IN	STD_LOGIC_VECTOR(3 downto 0);
		in_sel		:IN 	STD_LOGIC;
		o_d		: OUT	STD_LOGIC_VECTOR(3 downto 0));
END Multiplexer;

ARCHITECTURE rtl OF Multiplexer IS
SIGNAL int_d0, int_d1  : STD_LOGIC_VECTOR(3 downto 0);

BEGIN

int_d0 <= (not(in_sel) and i_d0(3)) & (not(in_sel) and i_d0(2)) & (not(in_sel) and i_d0(1)) & (not(in_sel) and i_d0(0));
int_d1<= (in_sel and i_d1(3)) & (in_sel and i_d1(2)) & (in_sel and i_d1(1)) & (in_sel and i_d1(0));
o_d <= int_d0 or int_d1;

End rtl;
