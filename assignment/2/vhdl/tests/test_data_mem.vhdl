library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.MyTypes.all;

entity data_memory_testbench is
	end data_memory_testbench;

architecture tb of data_memory_testbench is
	signal read_addr: std_logic_vector(5 downto 0) := (others => '0');
	signal write_addr: std_logic_vector(5 downto 0) := (others => '0');
	signal write_enable: std_logic_vector(3 downto 0) := (others => '0');
	signal clock: std_logic := '0';
	signal data_in: word := (others => '0');
	signal data_out: word;

	constant clock_period: time := 1 ns;
begin
	Data_Memory: entity work.data_memory port map (
				      read_addr => read_addr,
				      write_addr => write_addr,
				      write_enable => write_enable,
				      clock => clock,
				      data_in => data_in,
				      data_out => data_out
			      );

	clock <= not clock after clock_period;

	process
	begin
		read_addr <= (others => '0');
		for x in 0 to 15 loop
			write_enable <= std_logic_vector(to_unsigned(x, 4));
			for i in 0 to 63 loop
				write_addr <= std_logic_vector(to_unsigned(i, 6));
				data_in <= word(to_unsigned(63 - i + 1024 * x, 32));
				wait for 2 ns;
			end loop;
		end loop;

		write_enable <= "0000";
		for i in 0 to 63 loop
			read_addr <= std_logic_vector(to_unsigned(i, 6));
			wait for 2 ns;
		end loop;
		wait;
	end process;
end tb;
