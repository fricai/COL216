library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

use work.MyTypes.all;

entity alu is
	port(
	op1, op2: in word;
	result: out word;
	instr: in optype;
	carry_in: in std_logic;
	carry_out: out std_logic);
end alu;

architecture beh of alu is
	constant one: unsigned := to_unsigned(1, 32);
	signal tmp: unsigned(32 downto 0);
begin
	with instr select
		tmp <= unsigned(op1 and op2) when andop, -- 0000
		       unsigned(op1 xor op2) when eor, -- 0001
		       unsigned(op1) + unsigned(not op2) + one when sub, -- 0010
		       unsigned(not op1) + unsigned(op2) + one when rsb, -- 0011
		       unsigned(op1) + unsigned(op2) when add, -- 0100
		       unsigned(op1) + unsigned(op2) + unsigned'("" & carry_in) when adc, -- 0101
		       unsigned(op1) + unsigned(not op2) + unsigned'("" & carry_in) when sbc, -- 0110
		       unsigned(not op1) + unsigned(op2) + unsigned'("" & carry_in) when rsc, -- 0111
		       unsigned(op1 and op2) when tst, -- 1000
		       unsigned(op1 xor op2) when teq, -- 1001
		       unsigned(op1) + unsigned(not op2) + one when cmp, -- 1010
		       unsigned(op1) + unsigned(op2) when cmn, -- 1011
		       unsigned(op1 or op2) when orr, -- 1100
		       unsigned(op2) when mov, -- 1101
		       unsigned(op1) and unsigned(not op2) when bic, -- 1110
		       unsigned(not op2) when mvn; -- 1111
	result <= std_logic_vector(tmp(31 downto 0));
	carry_out <= tmp(32);
end beh;
