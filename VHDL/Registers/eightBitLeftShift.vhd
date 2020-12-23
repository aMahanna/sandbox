LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Eight Bit Register

ENTITY eightBitLeftShift IS
	PORT(
		i_resetBar, i_shift	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0));
END eightBitLeftShift;

ARCHITECTURE rtl OF eightBitLeftShift IS
	SIGNAL int_Value, int_notValue : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL int_MSBload, int_MSBenable : STD_LOGIC; 

	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;

BEGIN

-- Concurrent Signal Assignment
int_MSBload <= int_Value(7) or not(i_resetBar);
int_MSBenable <= i_shift or not(i_resetBar);

b_7: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => Int_MSBload, 
			  i_enable => int_MSBenable,
			  i_clock => i_clock,
			  o_q => int_Value(0),
	          o_qBar => int_notValue(0));

b_6: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_Value(0),
			  i_enable => i_shift, 
			  i_clock => i_clock,
			  o_q => int_Value(1),
	          o_qBar => int_notValue(1));

b_5: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_Value(1),
			  i_enable => i_shift, 
			  i_clock => i_clock,
			  o_q => int_Value(2),
	          o_qBar => int_notValue(2));

b_4: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_Value(2),
			  i_enable => i_shift, 
			  i_clock => i_clock,
			  o_q => int_Value(3),
	          o_qBar => int_notValue(3));

b_3: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_Value(3),
			  i_enable => i_shift, 
			  i_clock => i_clock,
			  o_q => int_Value(4),
	          o_qBar => int_notValue(4));

b_2: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_Value(4),
			  i_enable => i_shift, 
			  i_clock => i_clock,
			  o_q => int_Value(5),
	          o_qBar => int_notValue(5));

b_1: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_Value(5),
			  i_enable => i_shift, 
			  i_clock => i_clock,
			  o_q => int_Value(6),
	          o_qBar => int_notValue(6));

b_0: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_Value(6), 
			  i_enable => i_shift,
			  i_clock => i_clock,
			  o_q => int_Value(7),
	          o_qBar => int_notValue(7));

	-- Output Driver
	o_Value	<= int_Value;

END rtl;
