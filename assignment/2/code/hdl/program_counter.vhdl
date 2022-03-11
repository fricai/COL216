library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.MyTypes.all;

entity program_counter is
    port (
    clock, reset, enable: in std_logic;
    pc_in : in word;
    pc_out: out word);
end program_counter;

architecture beh of program_counter is
    signal pc: word;
begin
    pc_out <= pc;

    process(clock, reset, enable)
    begin
        if (rising_edge(clock)) then
            if (reset = '1') then
                pc <= (others => '0');
            elsif (enable = '1') then
                pc <= pc_in;
            end if;
        end if;
    end process;
end beh;
