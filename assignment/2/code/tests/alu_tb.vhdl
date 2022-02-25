library ieee;
use ieee.std_logic_1164.all;

use work.MyTypes.all;

entity alu_tb is
end alu_tb;

architecture tb of alu_tb is
 	signal op1, op2: word;
 	signal result: word;
 	signal instr: optype;
	signal carry_in: std_logic;
 	signal carry_out: std_logic;

	type op_constants_t is array (0 to 2) of word;
	constant op_constants: op_constants_t := (X"7FFF_FFFF", X"0000_0000", X"0000_0001");
begin
	ALU: entity work.alu port map (
		op1 => op1,
		op2 => op2,
		result => result,
		instr => instr,
		carry_in => carry_in,
		carry_out => carry_out
	);

	process
	begin
		for x in 0 to 2 loop
			op1 <= op_constants(x);
			for y in 0 to 2 loop
				op2 <= op_constants(y);
				for b in std_logic range '0' to '1' loop
					carry_in <= b;
					for opcode in optype range andop to mvn loop
						instr <= opcode;
						wait for 2 ns;
					end loop;
				end loop;
			end loop;
		end loop;
		wait;
	end process;
end tb;
