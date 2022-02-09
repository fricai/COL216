library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

use work.MyTypes.all;

entity alu is
	port(
	op1, op2: in word;
	res: out word;
	instr: in optype;
	carry_in: in std_logic;
	carry_out: out std_logic);
end alu;

architecture beh of alu is
	constant one: word := word(to_unsigned(1, 32));
begin
	with instr select
		res <= op1 and op2 when andop, -- 0000
		       op1 xor op2 when eor, -- 0001
		       word(unsigned(op1) + unsigned(not op2) + unsigned(one)) when sub, -- 0010
		       word(unsigned(not op1) + unsigned(op2) + unsigned(one)) when rsb, -- 0011
		       word(unsigned(op1) + unsigned(op2)) when add, -- 0100
		       word(unsigned(op1) + unsigned(op2) + unsigned'("" & carry_in)) when adc, -- 0101
		       word(unsigned(op1) + unsigned(not op2) + unsigned'("" & carry_in)) when sbc, -- 0110
		       word(unsigned(not op1) + unsigned(op2) + unsigned'("" & carry_in)) when rsc, -- 0111
		       op1 and op2 when tst, -- 1000
		       op1 xor op2 when teq, -- 1001
		       word(unsigned(op1) + unsigned(not op2) + unsigned(one)) when cmp, -- 1010
		       word(unsigned(op1) + unsigned(op2)) when cmn, -- 1011
		       op1 or op2 when orr, -- 1100
		       op2 when mov, -- 1101
		       op1 and (not op2) when bic, -- 1110
		       not op2 when mvn; -- 1111
	-- need to define how carry_out is affected
end beh;
