library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.MyTypes.all;

entity primary_memory_testbench is
end primary_memory_testbench;

architecture tb of primary_memory_testbench is
	signal read_addr: std_logic_vector(5 downto 0) := (others => '0');
	signal data_out: word;
begin
	Program_Memory: entity work.program_memory port map (
		read_addr => read_addr,
		data_out => data_out
	);

	process
	begin
		for i in 0 to 63 loop
			read_addr <= std_logic_vector(to_unsigned(i, 6));
			wait for 1 ns;
		end loop;
		wait;
	end process;
end tb;
