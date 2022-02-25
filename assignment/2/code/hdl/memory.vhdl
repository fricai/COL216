library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

use work.MyTypes.all;

entity memory is
	port(
		    addr: in word;
		    write_enable: in std_logic_vector(3 downto 0);
		    clock: in std_logic;
		    data_in: in word;
		    data_out: out word);
end memory;

architecture beh of memory is
	type mem_t is array(0 to 127) of word;
	signal mem: mem_t :=
	-- (
	--	0 => X"E3A00000",
	-- 	1 => X"E3A01000",
	--	2 => X"E0800001",
	-- 	3 => X"E2811001",
	-- 	4 => X"E3510005",
	-- 	5 => X"1AFFFFFB",
	-- 	others => X"00000000"
	--);

	(
	 	0 => X"E3A00040",
	 	1 => X"E3A01005",
	 	2 => X"E5801000",
	 	3 => X"E2811002",
	 	4 => X"E5801004",
	 	5 => X"E5902000",
	 	6 => X"E5903004",
	 	7 => X"E0434002",
	 	others => X"00000000"
	);
begin
	data_out <= mem(to_integer(unsigned(addr(8 downto 2))));
	-- get rid of last two bits

	process(clock, write_enable)
	begin
		if (rising_edge(clock)) then
			for i in 0 to 3 loop
				if (write_enable(i) = '1') then
					mem(to_integer(unsigned(addr(8 downto 2))))(8 * i + 7 downto 8 * i)
						<= data_in(8 * i + 7 downto 8 * i);
				end if;
			end loop;
		end if;
	end process;
end beh;
