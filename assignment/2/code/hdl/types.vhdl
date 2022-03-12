-- taken from moodle

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package MyTypes is
    subtype word     is std_logic_vector(31 downto 0);
    subtype hword    is std_logic_vector(15 downto 0);
    subtype byte     is std_logic_vector(7 downto 0);
    subtype nibble   is std_logic_vector(3 downto 0);
    subtype bit_pair is std_logic_vector(1 downto 0);

    type optype              is (andop, eor, sub, rsb, add, adc, sbc, rsc, tst, teq,
                                 cmp, cmn, orr, mov, bic, mvn);
    type instr_class_type    is (DP, DT, MUL, BRN, none);
    type DP_subclass_type    is (arith, logic, comp, test, none);
    type DP_operand_src_type is (reg, imm);
    type load_store_type     is (load, store);
    type DT_offset_sign_type is (plus, minus);

    -- my additions
    constant word_size     : integer := 32;
    constant log_word_size : integer := 5;

    type condtype           is (eq, ne, cs, cc, mi, pl, vs, vc, hi, ls, ge, lt, gt, le, al);
    type control_state_type is (fetch, read_AB, arith, load_DR, store_DR, branch_shift,
                                store_res, final_store, imm_shift_state, DP_variable_shift_read,
                                DP_variable_shift_shift, DP_imm_shift, DT_imm_offset_state,
                                DT_reg_offset_alu_state);
    type shift_type         is (lsl, lsr, asr, opror);

    -- attribute enum_encoding : string;
    -- attribute enum_encoding of condtype           : type is "sequential";
    -- attribute enum_encoding of optype             : type is "sequential";
    -- attribute enum_encoding of control_state_type : type is "sequential";
    -- attribute enum_encoding of shift_type         : type is "sequential";
end MyTypes;

package body MyTypes is
end MyTypes;
