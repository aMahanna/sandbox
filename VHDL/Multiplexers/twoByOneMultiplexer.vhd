LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY twobyoneMultiplexer IS
	PORT(
		i_d0, i_d1	: IN	STD_LOGIC;
		in_sel		:IN 	STD_LOGIC;
		o_d		: OUT	STD_LOGIC);
END twobyoneMultiplexer;


ARCHITECTURE rtl OF twobyoneMultiplexer IS
SIGNAL int_d0, int_d1  : STD_LOGIC;

BEGIN

int_d0 <= not(in_sel) and i_d0;
int_d1<= in_sel and i_d1;
o_d <= int_d0 or int_d1;

End rtl;
