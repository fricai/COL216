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
	signal mem: mem_t :=
	(
		0 => X"E3A00000",
		1 => X"E3A01000",
		2 => X"E0800001",
		3 => X"E2811001",
		4 => X"E3510005",
		5 => X"1AFFFFFB",
		others => X"00000000"
	);

	-- (
	-- 	0 => X"E3A00010",
	-- 	1 => X"E3A01005",
	-- 	2 => X"E5801000",
	-- 	3 => X"E2811002",
	-- 	4 => X"E5801004",
	-- 	5 => X"E5902000",
	-- 	6 => X"E5903004",
	-- 	7 => X"E0434002",
	-- 	others => X"00000000"
	-- );
begin
	data_out <= mem(to_integer(unsigned(addr(7 downto 2))));
-- get rid of last two bits
end beh;
