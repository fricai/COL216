library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.MyTypes.all;

entity program_counter is
	Port (
	reset, clock, branch: in std_logic;
	offset: in std_logic_vector(23 downto 0);
	read: out word);
end program_counter;

architecture beh of program_counter is
	signal pc: word := X"00000000";
	signal shifted: word;
begin
	read <= pc;

	process(reset, clock)
	begin
		if (reset = '1') then pc <= X"00000000";
		elsif (rising_edge(clock)) then
			if (branch = '0') then
				pc <= std_logic_vector(unsigned(pc) + 4);
			else
				pc <= std_logic_vector(unsigned(pc) + 8 +
					unsigned(resize(signed(offset & "00"), word_size)));
				-- resize signed should take care of sign extension
			end if;
		end if;
	end process;
end beh;
