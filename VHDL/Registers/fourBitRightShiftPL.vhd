LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Four Bit Shift Right Register with Parallel Loading

ENTITY fourBitRightShift IS
	PORT(
		i_resetBar, i_shiftR, i_load, i_clock	: IN	STD_LOGIC;
		in_Value			:IN 	STD_LOGIC_VECTOR(3 downto 0);
		o_b_0			:OUT 	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC_VECTOR(3 downto 0));
END fourBitRightShift;

ARCHITECTURE rtl OF fourBitRightShift IS
	SIGNAL int_Value, int_notValue, int_muxOut  : STD_LOGIC_VECTOR(3 downto 0);
SIGNAL int_enable: STD_LOGIC; 

	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;

	COMPONENT twobyoneMultiplexer
		PORT(
			i_d0, i_d1	: IN	STD_LOGIC;
			in_sel		:IN 	STD_LOGIC;
			o_d		: OUT	STD_LOGIC);
	END COMPONENT;

BEGIN

-- Concurrent Signal Assignment
int_enable <= i_shiftR or i_load;


b3_multiplexer: twobyoneMultiplexer
		PORT MAP (
			i_d0 =>'0',
i_d1 => in_Value(3),
in_sel => i_load,
			o_d => int_muxOut(3));
b2_multiplexer: twobyoneMultiplexer
		PORT MAP (
			i_d0 => int_Value(3),
i_d1 => in_Value(2),
in_sel => i_load,
			o_d => int_muxOut(2));
b1_multiplexer: twobyoneMultiplexer
		PORT MAP (
			i_d0 => int_Value(2),
i_d1 => in_Value(1),
in_sel => i_load,
			o_d => int_muxOut(1));
b0_multiplexer: twobyoneMultiplexer
		PORT MAP (
			i_d0 => int_Value(1),
i_d1 => in_Value(0),
in_sel => i_load,
			o_d => int_muxOut(0));

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
	o_b_0 <= int_Value(0);

END rtl;
