-- taken from Moodle

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.MyTypes.all;

entity decoder is
	port (
		     instruction    : in word;
		     instr_class    : out instr_class_type;
		     operation      : out optype;
		     DP_subclass    : out DP_subclass_type;
		     DP_operand_src : out DP_operand_src_type;
		     load_store     : out load_store_type;
		     DT_offset_sign : out DT_offset_sign_type;
		     cond           : out condtype;
		     S_bit          : out std_logic;
		     branch_offset  : out std_logic_vector(23 downto 0);
		     Rm, Rd, Rn     : out std_logic_vector(3 downto 0);
		     imm8           : out std_logic_vector(7 downto 0);
             imm12          : out std_logic_vector(11 downto 0);
             rottype        : out shift_type;
             shift5         : out std_logic_vector(4 downto 0);
             shift4         : out std_logic_vector(3 downto 0);
             shift_reg      : out std_logic_vector(3 downto 0));
end decoder;

architecture behavioral of decoder is
	type oparraytype is array (0 to 15) of optype;
	constant oparray: oparraytype := (andop, eor, sub, rsb, add, adc, sbc, rsc, tst, teq, cmp, cmn, orr, mov, bic, mvn);

	type condarraytype is array (0 to 14) of condtype;
	constant condarray: condarraytype := (eq, ne, cs, cc, mi, pl, vs, vc, hi, ls, ge, lt, gt, le, al);

    type rotarraytype is array(0 to 3) of shift_type;
    constant rotarray: rotarraytype := (lsl, lsr, asr, opror);
begin
	with instruction(27 downto 26) select
        instr_class <= DP when "00",
                       DT when "01",
                       BRN when "10",
                       none when others;
	operation <= oparray(to_integer(unsigned(instruction(24 downto 21))));

    with instruction(24 downto 22) select
        DP_subclass <= arith when "001" | "010" | "011",
                       logic when "000" | "110" | "111",
                       comp  when "101",
                       test  when others;

	DP_operand_src <= reg  when instruction(25) = '0' else imm;
	load_store     <= load when instruction(20) = '1' else store;
	DT_offset_sign <= plus when instruction(23) = '1' else minus;

	-- my addition
	cond  <= condarray(to_integer(unsigned(instruction(31 downto 28))));

	S_bit <= instruction(20);

	branch_offset <= instruction(23 downto 0);

	Rm <= instruction( 3 downto 0);
	Rd <= instruction(15 downto 12);
	Rn <= instruction(19 downto 16);

	imm8  <= instruction( 7 downto 0);
	imm12 <= instruction(11 downto 0);

	rottype   <= rotarray(to_integer(unsigned(instruction(6 downto 5))));
    shift5    <= instruction(11 downto 7);
    shift4    <= instruction(11 downto 8);
    shift_reg <= instruction(11 downto 8);
end behavioral;
