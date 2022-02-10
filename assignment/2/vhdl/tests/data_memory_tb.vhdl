library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.MyTypes.all;

entity data_memory_tb is
end data_memory_tb;

architecture tb of data_memory_tb is
	signal addr: word := (others => '0');
	signal write_enable: std_logic_vector(3 downto 0) := (others => '0');
	signal clock: std_logic := '0';
	signal data_in: word := (others => '0');
	signal data_out: word;

	constant clock_period: time := 1 ns;
begin
	Data_Memory: entity work.data_memory port map (
				      addr => addr,
				      write_enable => write_enable,
				      clock => clock,
				      data_in => data_in,
				      data_out => data_out
			      );

	clock <= not clock after clock_period;

	process
	begin
		for x in 0 to 15 loop
			write_enable <= std_logic_vector(to_unsigned(x, 4));
			for i in 0 to 63 loop
				addr <= std_logic_vector(to_unsigned(i, word_size));
				data_in <= word(to_unsigned(i + 256 * x, word_size));
				wait for 2 ns;
			end loop;
		end loop;

		write_enable <= "0000";
		for i in 0 to 63 loop
			addr <= std_logic_vector(to_unsigned(i, word_size));
			wait for 2 ns;
		end loop;
		wait;
	end process;
end tb;
