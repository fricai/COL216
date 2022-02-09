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
	signal tmp: unsigned(32 downto 0);
	signal op1_u, op2_u, nop1_u, nop2_u: unsigned(32 downto 0);
begin
	op1_u <= unsigned('0' & op1);
	op2_u <= unsigned('0' & op2);
	nop1_u <= unsigned('0' & (not op1));
	nop2_u <= unsigned('0' & (not op2));
	with instr select
		tmp <= op1_u and op2_u when andop, -- 0000
		       op1_u xor op2_u when eor, -- 0001
		       op1_u + nop2_u + unsigned'("1") when sub, -- 0010
		       nop1_u + op2_u + unsigned'("1") when rsb, -- 0011
		       op1_u + op2_u when add, -- 0100
		       op1_u + op2_u + unsigned'("" & carry_in) when adc, -- 0101
		       op1_u + nop2_u + unsigned'("" & carry_in) when sbc, -- 0110
		       nop1_u + op2_u + unsigned'("" & carry_in) when rsc, -- 0111
		       op1_u and op2_u when tst, -- 1000
		       op1_u xor op2_u when teq, -- 1001
		       op1_u + nop2_u + unsigned'("1") when cmp, -- 1010
		       op1_u + op2_u when cmn, -- 1011
		       op1_u or op2_u when orr, -- 1100
		       op2_u when mov, -- 1101
		       op1_u and nop2_u when bic, -- 1110
		       nop2_u when mvn; -- 1111
	result <= std_logic_vector(tmp(31 downto 0));
	carry_out <= tmp(32);
end beh;
