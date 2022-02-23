library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.MyTypes.all;

entity program_memory_tb is
end program_memory_tb;

architecture tb of program_memory_tb is
	signal addr: word := (others => '0');
	signal data_out: word;
begin
	Program_Memory: entity work.program_memory port map (
		addr => addr,
		data_out => data_out
	);

	process
	begin
		for i in 0 to 63 loop
			addr <= word(to_unsigned(i, word_size));
			wait for 1 ns;
		end loop;
		wait;
	end process;
end tb;
