library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.MyTypes.all;

entity reg_file_tb is
end reg_file_tb;

architecture tb of reg_file_tb is
	constant addr_size: integer := 4;

	signal read_addr1: std_logic_vector((addr_size - 1) downto 0) := (others => '0');
	signal read_addr2: std_logic_vector((addr_size - 1) downto 0) := (others => '0');
	signal write_addr: std_logic_vector((addr_size - 1) downto 0) := (others => '0');
	signal data_in: word;
	signal write_enable: std_logic := '0';
	signal clock: std_logic := '0';
	signal data_out1, data_out2: word;

	constant clk_period: time := 1 ns;
begin
	Register_File: entity work.reg_file port map (
				     read_addr1 => read_addr1,
				     read_addr2 => read_addr2,
				     write_addr => write_addr,
				     data_in => data_in,
				     write_enable => write_enable,
				     clock => clock,
				     data_out1 => data_out1,
				     data_out2 => data_out2
			     );

	clock <= not clock after clk_period / 2;

	process
	begin
		write_enable <= '1';
		for idx in 0 to 15 loop
			write_addr <= std_logic_vector(to_unsigned(idx, addr_size));
			data_in <= word(to_unsigned(idx, word_size)); -- set mem[idx] = idx

			-- read value from idx and 15 - idx
			read_addr1 <= std_logic_vector(to_unsigned(idx, addr_size));
			read_addr2 <= std_logic_vector(to_unsigned(15 - idx, addr_size));
			wait for 2 ns;
		end loop;

		write_enable <= '0';
		for idx1 in 0 to 15 loop
			for idx2 in 0 to 15 loop
				read_addr1 <= std_logic_vector(to_unsigned(idx1, addr_size));
				read_addr2 <= std_logic_vector(to_unsigned(idx2, addr_size));
				wait for 2 ns;
			end loop;
		end loop;
		wait;
	end process;
end tb;
