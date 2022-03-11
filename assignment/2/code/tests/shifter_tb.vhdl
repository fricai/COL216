library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.MyTypes.all;

entity shifter_tb is
end shifter_tb;

architecture tb of shifter_tb is
    signal input, output : word;
    signal cout          : std_logic;
    signal oper          : shift_type;
    signal amount        : std_logic_vector((log_word_size - 1) downto 0);

    type input_arr_t is array(0 to 3) of word;
    signal input_arr: input_arr_t := (X"0000_0001", X"FFFF_FFFE", X"7FA0_C654", X"A649_5839");
begin
    S: entity work.shifter port map (
                                        input  => input,
                                        amount => amount,
                                        oper   => oper,
                                        output => output,
                                        cout   => cout
                                    );

    process
    begin
        for x in 0 to (input_arr'length - 1) loop
            input <= input_arr(x);

            for i in 0 to (word_size - 1) loop
                amount <= std_logic_vector(to_unsigned(i, log_word_size));

                oper <= lsl;
                wait for 1 ns;
                assert output = to_stdlogicvector(to_bit_vector(input) sll i);

                oper <= lsr;
                wait for 1 ns;
                assert output = to_stdlogicvector(to_bit_vector(input) srl i);

                oper <= asr;
                wait for 1 ns;
                assert output = to_stdlogicvector(to_bit_vector(input) sra i);

                oper <= opror;
                wait for 1 ns;
                assert output = to_stdlogicvector(to_bit_vector(input) ror i);
            end loop;
        end loop;
        wait;
    end process;
end tb;
