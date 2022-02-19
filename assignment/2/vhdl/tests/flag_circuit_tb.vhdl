library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.MyTypes.all;

entity flag_circuit_tb is
	end flag_circuit_tb;

architecture tb of flag_circuit_tb is
	signal clock: std_logic := '0';
	signal enable: std_logic := '0';
	signal carry: std_logic := '0';
	signal DP_subclass: DP_subclass_type;
	signal operation: optype;
	signal op1_msb, op2_msb: std_logic;
	signal result, op1, op2: word;
	signal N, Z, C, V, S_bit: std_logic;

	constant clock_period: time := 1 ns;

	type op_constants_t is array (0 to 3) of word;
	constant op_constants: op_constants_t := (X"7FFF_FFFF", X"0000_0000", X"0000_0001", X"FFFF_FFFF");
begin
	F: entity work.flag_circuit port map (
						     clock => clock,
						     enable => enable,
						     alu_carry => carry,
						     shifter_carry => '0',
						     DP_subclass => DP_subclass,
						     operation => operation,
						     S_bit => S_bit,
						     op1 => op1_msb,
						     op2 => op2_msb,
						     result => result,
						     N => N, Z => Z, C => C, V => V
					     );

	ALU: entity work.alu port map (
						       op1 => op1,
						       op2 => op2,
						       result => result,
						       instr => operation,
						       carry_in => '0',
						       carry_out => carry
					       );

	clock <= not clock after clock_period / 2;

	op1_msb <= op1(word_size - 1);
	op2_msb <= op2(word_size - 1);

	process
	begin
		for x in 0 to 3 loop
			op1 <= op_constants(x);

			enable <= '1';
			S_bit <= '1';
			operation <= cmp;
			DP_subclass <= comp;
			for y in 0 to 3 loop
				op2 <= op_constants(y);
				wait for clock_period;
			end loop;

			enable <= '1';
			S_bit <= '0';
			operation <= add;
			DP_subclass <= arith;
			for y in 0 to 3 loop
				op2 <= op_constants(y);
				wait for clock_period;
			end loop;

			enable <= '0';
			S_bit <= '1';
			operation <= cmp;
			DP_subclass <= comp;
			for y in 0 to 3 loop
				op2 <= op_constants(y);
				wait for clock_period;
			end loop;
		end loop;
		wait;
	end process;
end tb;
