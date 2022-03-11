library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

use work.MyTypes.all;

entity processor is port(clock, reset: in std_logic);
end processor;

architecture rtl of processor is
    signal control_state : control_state_type;

    -- PC
    signal pc_reset, pc_write_en : std_logic;
    signal pc_in, pc_out         : word;

    -- registers
    signal IR, A, B, D, X, Res, DR: word;

    -- Instruction Decoder
    signal instr_class    : instr_class_type;
    signal operation      : optype;
    signal DP_subclass    : DP_subclass_type;
    signal DP_operand_src : DP_operand_src_type;
    signal load_store     : load_store_type;
    signal DT_offset_sign : DT_offset_sign_type;
    signal cond_field     : condtype;
    signal branch_offset  : std_logic_vector(23 downto 0);
    signal Rd, Rn, Rm     : std_logic_vector(3 downto 0);
    signal S_bit          : std_logic;
    signal imm8           : std_logic_vector(7 downto 0);
    signal imm12          : std_logic_vector(11 downto 0);
    signal shift5         : std_logic_vector(4 downto 0);
    signal shift4         : std_logic_vector(3 downto 0);
    signal shift_reg      : std_logic_vector(3 downto 0);
    signal rottype        : shift_type;


    -- ALU
    signal operand1, operand2, alu_out : word;
    signal alu_op                      : optype;
    signal alu_cin, alu_cout           : std_logic;

    -- Reg File
    signal reg_read_addr1, reg_read_addr2, reg_write_addr : std_logic_vector(3 downto 0);
    signal reg_in, reg_out1, reg_out2                     : word;
    signal reg_write_en                                   : std_logic;

    -- Flag circuit
    signal N_flag, Z_flag, C_flag, V_flag : std_logic;
    signal F_en                           : std_logic;

    -- Condition checker
    signal cond_true : std_logic;

    -- Memory
    signal mem_write_en              : std_logic_vector(3 downto 0);
    signal mem_in, mem_addr, mem_out : word;

    -- Shifter
    signal shifter_input, shifter_output : word;
    signal shifter_cout                  : std_logic;
    signal shift_op                      : shift_type;
    signal shift_amount                  : std_logic_vector((log_word_size - 1) downto 0);
begin
    PC: entity work.program_counter port map(
                            -- input
                            clock     => clock,
                            reset     => pc_reset,
                            enable    => pc_write_en,
                            pc_in     => pc_in,

                            -- output
                            pc_out    => pc_out
                        );

    F: entity work.flag_circuit port map (
                             -- input
                             clock         => clock,
                             enable        => F_en,
                             op1           => operand1(word_size - 1),
                             op2           => operand2(word_size - 1),
                             result        => alu_out,
                             DP_subclass   => DP_subclass,
                             operation     => alu_op,
                             S             => S_bit,
                             alu_carry     => alu_cout,
                             shifter_carry => '0',

                             -- output
                             N => N_flag,
                             Z => Z_flag,
                             C => C_flag,
                             V => V_flag
                         );

    ALU: entity work.alu port map (
                          -- input
                          instr     => alu_op,
                          op1       => operand1,
                          op2       => operand2,
                          carry_in  => alu_cin,

                          -- output
                          result    => alu_out,
                          carry_out => alu_cout
                      );

    RF: entity work.reg_file port map (
                          -- input
                          clock        => clock,
                          write_enable => reg_write_en,
                          read_addr1   => reg_read_addr1,
                          read_addr2   => reg_read_addr2,
                          write_addr   => reg_write_addr,
                          data_in      => reg_in,

                          -- output
                          data_out1 => reg_out1,
                          data_out2 => reg_out2
                      );

    MEM: entity work.memory port map (
                         -- input
                         clock        => clock,
                         write_enable => mem_write_en,
                         addr         => mem_addr,
                         data_in      => mem_in,

                         -- output
                         data_out     => mem_out
                     );

    S: entity work.shifter port map (
                                        -- input
                                        input  => shifter_input,
                                        amount => shift_amount,
                                        oper   => shift_op,
                                        -- output
                                        output => shifter_output,
                                        cout   => shifter_cout
                                    );

    pc_reset <= '0' when reset = '0' else '1';
    pc_in <= alu_out(29 downto 0) & "00";

    process(control_state, operation, A, B, C_flag, Rn, Rm, Rd, DR, pc_out, instr_class,
        DP_operand_src, imm8, Res, imm12, DT_offset_sign, cond_true, branch_offset)
    begin
        -- default values

        -- Program Counter
        pc_write_en <= '0';

        -- Flag Circuit
        F_en <= '0';

        -- ALU
        alu_op   <= operation;
        operand1 <= A;
        operand2 <= D; -- this got changed from B to D
        alu_cin  <= C_flag;

        -- RF
        reg_write_en   <= '0';
        reg_read_addr1 <= Rn;
        reg_read_addr2 <= Rm;
        reg_write_addr <= Rd;
        reg_in         <= DR;

        -- MEM
        mem_write_en <= "0000";
        mem_addr     <= pc_out;
        mem_in       <= B;

        -- shifter
        shifter_input <= B;
        shift_amount  <= shift5;
        shift_op      <= rottype;

        case control_state is
            when fetch =>
                pc_write_en <= '1';
                alu_op      <= adc;
                operand1    <= "00" & pc_out(31 downto 2);
                operand2    <= (others => '0');
                alu_cin     <= '1';
            when read_AB =>
                if (instr_class = DT) then
                    reg_read_addr2 <= Rd;
                end if;
            when arith =>
                F_en <= '1';
                -- We instead store the rotated immediate value in X
                -- if (DP_operand_src = imm) then
                --  operand2 <= X"000000" & imm8;
                -- end if;
            when store_res =>
                -- write for logical and arithmetic operations only
                if (DP_subclass = arith or DP_subclass = logic) then
                    reg_write_en <= '1';
                    reg_in       <= Res;
                end if;
            when load_resB =>
                reg_read_addr2 <= Rd;
                operand2       <= X"00000" & imm12;
                case DT_offset_sign is
                    when plus  => alu_op <= add;
                    when minus => alu_op <= sub;
                end case;
            when final_store =>
                mem_addr     <= res;
                mem_write_en <= "1111";
            when load_DR =>
                mem_addr <= res;
            when store_DR =>
                reg_write_en <= '1';
                    -- store DR into Rd
            when branch_shift =>
                    -- load alu output into PC, take care of beq, bne too
                pc_write_en <= cond_true; -- if the condition is true, you increment pc
                alu_op      <= adc;
                operand1    <= "00" & pc_out((word_size - 1) downto 2);
                operand2    <= word(resize(signed(branch_offset), word_size));
                alu_cin     <= '1';
            when constant_shift => null;
            when variable_shift_read =>
                reg_read_addr1 <= shift_reg;
            when variable_shift_shift =>
                shift_amount <= X((log_word_size - 1) downto 0);
            when imm_shift =>
                shifter_input <= std_logic_vector(resize(unsigned(imm8), word_size));
                shift_op      <= opror;
                shift_amount  <= shift4 & "0";
        end case;
    end process;

    ID: entity work.decoder port map (
                         -- input
                         instruction => IR,

                         -- output
                         instr_class    => instr_class,
                         operation      => operation,
                         DP_subclass    => DP_subclass,
                         DP_operand_src => DP_operand_src,
                         load_store     => load_store,
                         DT_offset_sign => DT_offset_sign,
                         cond           => cond_field,
                         S_bit          => S_bit,
                         branch_offset  => branch_offset,
                         Rm => Rm, Rd => Rd, Rn => Rn,
                         imm8 => imm8, imm12 => imm12,
                         rottype        => rottype,
                         shift5         => shift5,
                         shift4         => shift4,
                         shift_reg      => shift_reg
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

    -- control FSM
    process(clock, reset, alu_out)
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
                        when DP =>
                            case DP_operand_src is
                                when reg =>
                                    case IR(4) is -- constant shift or not
                                        when '0'    => control_state <= constant_shift;
                                        when others => control_state <= variable_shift_read;
                                    end case;
                                when imm => control_state <= imm_shift;
                            end case;
                        when DT  => control_state <= load_resB;
                        when BRN => control_state <= branch_shift;
                        when others => null;
                    end case;
                when arith =>
                    Res           <= alu_out;
                    control_state <= store_res;
                when store_res =>
                    -- store into Rd from Res
                    control_state <= fetch;
                when load_resB =>
                    B   <= reg_out2;
                    Res <= alu_out;
                    case load_store is
                        when store => control_state <= final_store;
                        when load  => control_state <= load_dr;
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
                    control_state <= fetch;
                when constant_shift =>
                    D             <= shifter_output;
                    control_state <= arith;
                when variable_shift_read =>
                    X             <= reg_out1;
                    control_state <= variable_shift_shift;
                when variable_shift_shift =>
                    D             <= shifter_output;
                    control_state <= arith;
                when imm_shift =>
                    D             <= shifter_output;
                    control_state <= arith;
            end case;
        end if;
    end process;
end rtl;
