LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Eight Bit Shift Left Register with Parallel Loading

ENTITY eightBitLeftShiftPL IS
	PORT(
		i_resetBar, i_shiftL, i_load, i_clock	: IN	STD_LOGIC;
		in_Value			:IN 	STD_LOGIC_VECTOR(3 downto 0);
		o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0));
END eightBitLeftShiftPL;

ARCHITECTURE rtl OF eightBitLeftShiftPL IS
	SIGNAL int_Value, int_notValue, int_muxOut  : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL int_enable : STD_LOGIC; 

	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;

	-- Parallel Loading is optional
	COMPONENT twobyoneMultiplexer
		PORT(
			i_d0, i_d1	: IN	STD_LOGIC;
			in_sel		:IN 	STD_LOGIC;
			o_d		: OUT	STD_LOGIC);
	END COMPONENT;

BEGIN

-- Concurrent Signal Assignment
int_enable <= i_shiftL or i_load;


b7_multiplexer: twobyoneMultiplexer
		PORT MAP (
			i_d0 => int_Value(6),
i_d1 => in_Value(3),
in_sel => i_load,
			o_d => int_muxOut(7));



b6_multiplexer: twobyoneMultiplexer
		PORT MAP (
			i_d0 => int_Value(5),
i_d1 => in_Value(3),
in_sel => i_load,
			o_d => int_muxOut(6));
			
b5_multiplexer: twobyoneMultiplexer
		PORT MAP (
			i_d0 => int_Value(4),
i_d1 => in_Value(3),
in_sel => i_load,
			o_d => int_muxOut(5));
			
b4_multiplexer: twobyoneMultiplexer
		PORT MAP (
			i_d0 => int_Value(3),
i_d1 => in_Value(3),
in_sel => i_load,
			o_d => int_muxOut(4));
			
b3_multiplexer: twobyoneMultiplexer
		PORT MAP (
			i_d0 => int_Value(2),
i_d1 => in_Value(3),
in_sel => i_load,
			o_d => int_muxOut(3));
			
b2_multiplexer: twobyoneMultiplexer
		PORT MAP (
			i_d0 => int_Value(1),
i_d1 => in_Value(2),
in_sel => i_load,
			o_d => int_muxOut(2));
			
b1_multiplexer: twobyoneMultiplexer
		PORT MAP (
			i_d0 => int_Value(0),
i_d1 => in_Value(1),
in_sel => i_load,
			o_d => int_muxOut(1));
			
b0_multiplexer: twobyoneMultiplexer
		PORT MAP (
			i_d0 =>'0',
i_d1 => in_Value(0),
in_sel => i_load,
			o_d => int_muxOut(0));

b_7: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d =>int_muxOut(7), 
			  i_enable => int_enable,
			  i_clock => i_clock,
			  o_q => int_Value(7),
	          o_qBar => int_notValue(7));

b_6: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_muxOut(6),
			  i_enable => int_enable, 
			  i_clock => i_clock,
			  o_q => int_Value(6),
	          o_qBar => int_notValue(6));

b_5: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_muxOut(5),
			  i_enable => int_enable, 
			  i_clock => i_clock,
			  o_q => int_Value(5),
	          o_qBar => int_notValue(5));

b_4: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_muxOut(4),
			  i_enable => int_enable, 
			  i_clock => i_clock,
			  o_q => int_Value(4),
	          o_qBar => int_notValue(4));

b_3: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_muxOut(3),
			  i_enable => int_enable, 
			  i_clock => i_clock,
			  o_q => int_Value(3),
	          o_qBar => int_notValue(3));

b_2: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_muxOut(2),
			  i_enable => int_enable, 
			  i_clock => i_clock,
			  o_q => int_Value(2),
	          o_qBar => int_notValue(2));

b_1: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_muxOut(1),
			  i_enable => int_enable, 
			  i_clock => i_clock,
			  o_q => int_Value(1),
	          o_qBar => int_notValue(1));

b_0: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_muxOut(0), 
			  i_enable => int_enable,
			  i_clock => i_clock,
			  o_q => int_Value(0),
	          o_qBar => int_notValue(0));

	-- Output Driver
	o_Value	<= int_Value;

END rtl;
