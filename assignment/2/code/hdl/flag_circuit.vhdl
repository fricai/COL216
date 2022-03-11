library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.MyTypes.all;

entity flag_circuit is
    Port (
    clock, enable, alu_carry, shifter_carry: in std_logic;
    DP_subclass: in DP_subclass_type;
    operation: in optype;

    S: in std_logic;
    op1, op2: in std_logic;
    result: in word;

    N: out std_logic := '0';
    Z: out std_logic := '0';
    C: out std_logic := '0';
    V: out std_logic := '0');
end flag_circuit;

architecture beh of flag_circuit is
    signal res_b: std_logic;
begin
    -- I don't use shifter_carry here (don't know how to check for it either)

    res_b <= result(word_size - 1);



    process(clock, enable)
    begin
        if (enable = '1' and rising_edge(clock)) then
            case DP_subclass is
                when comp => 
                    C <= alu_carry;

                    case result is
                        when X"00000000" => Z <= '1';
                        when others => Z <= '0';
                    end case;

                    N <= res_b;
                    case operation is
                        when cmp =>
                            V <= (op1 and op2 and (not res_b)) or
                                 ((not op1) and (not op2) and res_b);
                        when others =>
                            V <= (op1 and (not op2) and (not res_b)) or
                                 ((not op1) and op2 and res_b);
                    end case;
                -- do nothing with arithmetic operations
                when test => 
                    case result is
                        when X"00000000" => Z <= '1';
                        when others => Z <= '0';
                    end case;
                    N <= res_b;

                when others =>
                    assert S = '0' report "Non-zero S in flag circuit" severity failure;
            -- just assume S_bit is always 0
            end case;
        end if;
    end process;
end beh;
