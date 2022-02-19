library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

use work.MyTypes.all;

-- refer to page 40 of lecture 9 for the port mappings
entity processor is
	port(
	clock, reset: in std_logic
-- PW, Psrc, Rsrc, RW, Fset, Asrc, MW, M2R: in std_logic
);
end processor;

architecture rtl of processor is
	signal branch_offset: std_logic_vector(23 downto 0);
	signal branch: std_logic;
	signal p_addr: word;

	signal instruction: word;

	signal instr_class: instr_class_type;
	signal operation: optype;
	signal DP_subclass: DP_subclass_type;
	signal DP_operand_src: DP_operand_src_type;
	signal load_store: load_store_type;
	signal DT_offset_sign: DT_offset_sign_type;
	signal cond_field: condtype;

	signal reg_addr2: std_logic_vector(3 downto 0);
	signal reg_in, reg_out1, reg_out2: word;
	signal reg_en: std_logic;

	signal operand1, operand2, alu_out: word;
	signal alu_carry: std_logic;

	signal N_flag, Z_flag, C_flag, V_flag: std_logic;
	signal F_en: std_logic;

	signal cond_true: std_logic;

	signal DM_en: std_logic_vector(3 downto 0);
	signal DM_out: word;

	signal Rd, Rn, Rm: std_logic_vector(3 downto 0);

	signal alu_op: optype;

	signal S_bit: std_logic;
begin
	PC: entity work.program_counter port map (
							 clock => clock,
							 reset => reset,
							 offset => branch_offset,
							 branch => branch,
							 read => p_addr
						 );

	branch_offset <= instruction(23 downto 0);
	branch <= '1' when instr_class = BRN and cond_true = '1' else '0';

	IM: entity work.program_memory port map (
							addr => p_addr,
							data_out => instruction
						);

	ID: entity work.decoder port map (
						 instruction => instruction,
						 instr_class => instr_class,
						 operation => operation,
						 DP_subclass => DP_subclass,
						 DP_operand_src => DP_operand_src,
						 load_store => load_store,
						 DT_offset_sign => DT_offset_sign,
						 cond => cond_field,
						 S_bit => S_bit
					 );

	Rm <= instruction(3 downto 0);
	Rd <= instruction(15 downto 12);
	Rn <= instruction(19 downto 16);
	reg_addr2 <= Rd when instr_class = DT else Rm; -- used only with str

	RF: entity work.reg_file port map (
						  clock => clock,
						  write_enable => reg_en,
						  read_addr1 => Rn,
						  read_addr2 => reg_addr2,
						  write_addr => Rd,
						  data_in => reg_in,
						  data_out1 => reg_out1,
						  data_out2 => reg_out2
					  );
	reg_in <= DM_out when instr_class = DT else alu_out;
	reg_en <= '1' when (instr_class = DT and load_store = store) or
		  (instr_class = DP and (DP_subclass = arith or DP_subclass = logic)) else
		  '0';

	operand1 <= reg_out1;
	operand2 <= std_logic_vector(resize(unsigned(instruction(11 downto 0)), word_size))
		    when DP_operand_src = imm or instr_class = DT else
		    reg_out2;
	alu_op <= operation when instr_class = DP else
		  add when DT_offset_sign = plus else
		  sub;  -- DT_offest_sign = minus
	ALU: entity work.alu port map (
					      instr => alu_op,
					      op1 => operand1,
					      op2 => operand2,
					      result => alu_out,
					      carry_in => C_flag,
					      carry_out => alu_carry
				      );

	F_en <= S_bit when instr_class = DP else '0';
	F: entity work.flag_circuit port map (
						     clock => clock,
						     enable => F_en,
						     op1 => operand1(word_size - 1),
						     op2 => operand2(word_size - 1),
						     result => alu_out,
						     DP_subclass => DP_subclass,
						     operation => alu_op,
						     S_bit => S_bit,
						     alu_carry => alu_carry,
						     shifter_carry => '0',
						     N => N_flag,
						     Z => Z_flag,
						     C => C_flag,
						     V => V_flag
					     );

	CC: entity work.cond_checker port map (
						      N => N_flag,
						      Z => Z_flag,
						      C => C_flag,
						      V => V_flag,
						      cond => cond_field,
						      res => cond_true
					      );

	DM_en <= "1111" when instr_class = DT and load_store = load else "0000";
	DM: entity work.data_memory port map (
						     clock => clock,
						     write_enable => DM_en,
						     addr => alu_out,
						     data_in => reg_out2,
						     data_out => DM_out
					     );
end rtl;
