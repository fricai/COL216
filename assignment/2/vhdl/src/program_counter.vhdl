library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.MyTypes.all;

entity program_counter is
	Port (
	reset, clock, branch: in std_logic;
	offset: in word;
	read: out word);
end program_counter;

architecture beh of program_counter is
	signal pc: word;
begin
	read <= pc;
	process(reset, clock)
	begin
		if (reset = '1') then pc <= (others => '0');
		elsif (rising_edge(clock)) then
			case branch is
				when '0' => pc <= std_logic_vector(signed(pc) + 4);
				when others => pc <= std_logic_vector(signed(pc) + 8 + resize(signed(offset & "00"), word_size));
				-- resize signed should take care of sign extension
			end case;
		end if;
	end process;
end beh;
