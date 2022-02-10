library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

use work.MyTypes.all;

entity data_memory is
	port(
		    addr: in word;
		    write_enable: in std_logic_vector(3 downto 0);
		    clock: in std_logic;
		    data_in: in word;
		    data_out: out word);
end data_memory;

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.MyTypes.all;

entity program_memory is
	port(
		    addr: in word;
		    data_out: out word);
end program_memory;

architecture beh of program_memory is
	type mem_t is array(0 to 63) of word;
	signal mem: mem_t;
begin
	set_data: for i in 0 to 63 generate
		mem(i) <= word(to_unsigned(i, word_size));
	end generate;

	data_out <= mem(to_integer(unsigned(addr)));
end beh;

architecture beh of data_memory is
	type mem_t is array(0 to 63) of word;
	signal mem: mem_t;
begin
	data_out <= mem(to_integer(unsigned(addr)));

	process(clock)
	begin
		if (rising_edge(clock)) then
			for i in 0 to 3 loop
				if (write_enable(i) = '1') then
					mem(to_integer(unsigned(addr)))(8 * i + 7 downto 8 * i) <= data_in(8 * i + 7 downto 8 * i);
				end if;
			end loop;
		end if;
	end process;
end beh;
