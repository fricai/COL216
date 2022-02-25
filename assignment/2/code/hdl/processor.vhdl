library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

use work.MyTypes.all;

entity processor is port(clock, reset: in std_logic);
end processor;

architecture rtl of processor is
	signal control_state: control_state_type;

	-- PC
	signal pc_reset, pc_en: std_logic;
	signal pc_in, pc_out: word;

	-- registers
	signal IR, A, B, Res, DR: word;

	-- Instruction Decoder
	signal instr_class: instr_class_type;
	signal operation: optype;
	signal DP_subclass: DP_subclass_type;
	signal DP_operand_src: DP_operand_src_type;
	signal load_store: load_store_type;
	signal DT_offset_sign: DT_offset_sign_type;
	signal cond_field: condtype;
	signal branch_offset: std_logic_vector(23 downto 0);
	signal Rd, Rn, Rm: std_logic_vector(3 downto 0);
	signal S_bit: std_logic;

	-- ALU
	signal operand1, operand2, alu_out: word;
	signal alu_op: optype;
	signal alu_cin, alu_cout: std_logic;

	-- Reg File
	signal reg_read_addr1, reg_read_addr2, reg_write_addr: std_logic_vector(3 downto 0);
	signal reg_in, reg_out1, reg_out2: word;
	signal reg_en: std_logic;

	-- Flag circuit
	signal N_flag, Z_flag, C_flag, V_flag: std_logic;
	signal F_en: std_logic;

	-- Condition checker
	signal cond_true: std_logic;

	-- Memory
	signal mem_en: std_logic_vector(3 downto 0);
	signal mem_in, mem_addr, mem_out: word;
begin
	PC: entity work.program_counter port map(
							clock => clock,
							reset => pc_reset,
							enable => pc_en,
							pc_in => pc_in,
							pc_out => pc_out
						);

	process(control_state, IR, operation, A, B, N_flag, Z_flag, C_flag, V_flag, pc_out)
	begin

	end process;


	process(clock, reset)
	begin
		if (reset = '1') then
			control_state <= fetch;
		elsif (rising_edge(clock)) then
			case control_state is
				when fetch =>
					IR <= mem_out;
					control_state <= read_AB;
				when read_AB =>
					A <= reg_out1;
					B <= reg_out2;
					case instr_class is
						when DP => control_state <= arith;
						when DT => control_state <= load_resB;
						when BRN => control_state <= branch_shift;
						when others => null;
					end case;
				when arith =>
					Res <= alu_out;
					control_state <= store_res;
				when store_res =>
					-- store into Rd from Res
					control_state <= fetch;
				when load_resB =>
					Res <= alu_out;
					case load_store is
						when store => control_state <= final_store;
						when load => control_state <= load_dr;
					end case;
				when final_store =>
					-- load into mem[Res] from B
					control_state <= fetch;
				when load_DR =>
					-- load into DR from mem[Res]
					DR <= mem_out;
					control_state <= store_dr;
				when store_DR =>
					-- store DR into Rd
					control_state <= fetch;
				when branch_shift =>
					-- load alu output into PC
					control_state <= fetch;
			end case;
		end if;
	end process;

	ID: entity work.decoder port map (
						 -- input
						 instruction => IR,

						 -- output
						 instr_class => instr_class,
						 operation => operation,
						 DP_subclass => DP_subclass,
						 DP_operand_src => DP_operand_src,
						 load_store => load_store,
						 DT_offset_sign => DT_offset_sign,
						 cond => cond_field,
						 S_bit => S_bit,
						 branch_offset => branch_offset,
						 Rm => Rm, Rd => Rd, Rn => Rn
					 );

	RF: entity work.reg_file port map (
						  -- input
						  clock => clock,
						  write_enable => reg_en,
						  read_addr1 => reg_read_addr1,
						  read_addr2 => reg_read_addr2,
						  write_addr => reg_write_addr,
						  data_in => reg_in,

						  -- output
						  data_out1 => reg_out1,
						  data_out2 => reg_out2
					  );
	ALU: entity work.alu port map (
					      -- input
					      instr => alu_op,
					      op1 => operand1,
					      op2 => operand2,
					      carry_in => alu_cin,

					      -- output
					      result => alu_out,
					      carry_out => alu_cout
				      );

	F: entity work.flag_circuit port map (
						     -- input
						     clock => clock,
						     enable => F_en,
						     op1 => operand1(word_size - 1),
						     op2 => operand2(word_size - 1),
						     result => alu_out,
						     DP_subclass => DP_subclass,
						     operation => alu_op,
						     S => S_bit,
						     alu_carry => alu_cout,
						     shifter_carry => '0',

						     -- output
						     N => N_flag,
						     Z => Z_flag,
						     C => C_flag,
						     V => V_flag
					     );

	CC: entity work.cond_checker port map (
						      -- input
						      N => N_flag,
						      Z => Z_flag,
						      C => C_flag,
						      V => V_flag,
						      cond => cond_field,

						      -- output
						      res => cond_true
					      );

	MEM: entity work.memory port map (
						 -- input
						 clock => clock,
						 write_enable => mem_en,
						 addr => mem_addr,
						 data_in => mem_in,

						 -- output
						 data_out => mem_out
					 );
end rtl;
