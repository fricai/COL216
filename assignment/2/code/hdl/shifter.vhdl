library ieee;
use ieee.std_logic_1164.all;
use work.MyTypes.all;

entity constant_shifter is
    generic(amount: integer);
    port (
             input : in word;
             sel   : in std_logic;
             cin   : in std_logic;
             oper  : in shift_type;
             output: out word;
             cout  : out std_logic);
    -- do a right shift by amount
end constant_shifter;

architecture rtl of constant_shifter is
begin
    bottom_shift:
    for i in 0 to (word_size - amount - 1) generate
        output(i) <= input(i) when sel = '0' else
                     input(i + amount);
    end generate;

    cout <= cin when sel = '0' else
            input(amount - 1);

    top_shift:
    for i in (word_size - amount) to (word_size - 1) generate
        output(i) <= input(i)                      when sel = '0'    else
                     input(i + amount - word_size) when oper = opror else
                     input(word_size - 1)          when oper = asr   else
                     '0';                            -- lsl or lsr
    end generate;
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use work.MyTypes.all;

entity reverser is
    port(
            input : in word;
            sel   : in std_logic;
            output: out word);
end reverser;

architecture rtl of reverser is
begin
    only_gen:
    for i in 0 to (word_size - 1) generate
        output(i) <= input(word_size - i - 1) when sel = '1' else
                     input(i);
    end generate;
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use work.MyTypes.all;

entity shifter is
    port(
            input : in word;
            amount: in std_logic_vector((log_word_size - 1) downto 0);
            oper  : in shift_type;
            output: out word;
            cout  : out std_logic);
end shifter;

architecture rtl of shifter is
    signal left_shift: std_logic;

    type inter_out_t is array(0 to log_word_size) of word;
    signal inter_out: inter_out_t;

    type inter_c_t is array(0 to log_word_size) of std_logic;
    signal inter_c: inter_c_t;
begin
    left_shift <= '1' when oper = lsl else '0';
    inter_c(0) <= '0';

    -- reverse
    rev: entity work.reverser
    port map(input => input, sel => left_shift, output => inter_out(0));

    constant_shifts:
    for i in 0 to (log_word_size - 1) generate
        power_of_two_shift: entity work.constant_shifter generic map(2 ** i)
        port map(
                    input  => inter_out(i),
                    output => inter_out(i + 1),
                    oper   => oper,
                    sel    => amount(i),
                    cin    => inter_c(i),
                    cout   => inter_c(i + 1));
    end generate;

    -- reverse
    inv_rev: entity work.reverser
    port map(input => inter_out(log_word_size), sel => left_shift, output => output);
    cout <= inter_c(log_word_size);
end rtl;
