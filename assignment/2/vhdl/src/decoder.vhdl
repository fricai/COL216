-- taken from Moodle

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.MyTypes.all;

entity decoder is
	Port (
		     instruction : in word;
		     instr_class : out instr_class_type;
		     operation : out optype;
		     DP_subclass : out DP_subclass_type;
		     DP_operand_src : out DP_operand_src_type;
		     load_store : out load_store_type;
		     DT_offset_sign : out DT_offset_sign_type
		     cond: out condtype;
	     );
end decoder;

architecture behavioral of decoder is
	type oparraytype is array (0 to 15) of optype;
	constant oparray : oparraytype := (andop, eor, sub, rsb, add, adc, sbc, rsc, tst, teq, cmp, cmn, orr, mov, bic, mvn);

	type condarraytype is array (0 to 14) of condtype;
	constant condarray : condarraytype := (eq, ne, cs, cc, mi, pl, vs, vc, hi, ls, ge, lt, gt, le, al);
begin
	with instruction (27 downto 26) select
		instr_class <= DP when "00",
			       DT when "01",
			       BRN when "10",
			       none when others;
	operation <= oparray(to_integer(unsigned(instruction(24 downto 21))));

	with instruction(24 downto 22) select
		DP_subclass <= arith when "001" | "010" | "011",
			       logic when "000" | "110" | "111",
			       comp when "101",
			       test when others;

	DP_operand_src <= reg when instruction(25) = '0' else imm;
	load_store <= load when instruction(20) = '1' else store;
	DT_offset_sign <= plus when instruction(23) = '1' else minus;

	cond <= condarray(to_integer(unsigned(instruction(31 downto 28)))); -- my addition
end behavioral;
