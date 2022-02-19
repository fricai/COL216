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

architecture beh of data_memory is
	type mem_t is array(0 to 63) of word;
	signal mem: mem_t;

begin
	data_out <= mem(to_integer(unsigned(addr(7 downto 2))));
	-- get rid of last two bits

	process(clock)
	begin
		if (rising_edge(clock)) then
			for i in 0 to 3 loop
				if (write_enable(i) = '1') then
					mem(to_integer(unsigned(addr(7 downto 2))))(8 * i + 7 downto 8 * i)
						<= data_in(8 * i + 7 downto 8 * i);
				end if;
			end loop;
		end if;
	end process;
end beh;
