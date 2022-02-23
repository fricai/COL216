library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

use work.MyTypes.all;

entity reg_file is
	port(
	read_addr1, read_addr2, write_addr: in std_logic_vector(3 downto 0);
	data_in: in word;
	write_enable: in std_logic;
	clock: in std_logic;
	data_out1, data_out2: out word);
end reg_file;

architecture beh of reg_file is
	type mem_t is array(0 to 15) of word;
	signal mem: mem_t; -- := (others => (others => '0'));
begin
	data_out1 <= mem(to_integer(unsigned(read_addr1)));
	data_out2 <= mem(to_integer(unsigned(read_addr2)));

	process(clock)
	begin
		if (rising_edge(clock) and (write_enable = '1')) then
			mem(to_integer(unsigned(write_addr))) <= data_in;
		end if;
	end process;
end beh;

