library ieee;
use ieee.std_logic_1164.all;

use work.MyTypes.all;

entity program_counter_tb is
end program_counter_tb;

architecture tb of program_counter_tb is
	signal reset: std_logic := '1';
	signal clock: std_logic := '0';
	signal branch: std_logic := '0';
	signal offset: std_logic_vector(23 downto 0) := (others => '0');
	signal read: word;

	constant clock_period: time := 1 ns;
begin
	PC: entity work.program_counter port map (
		reset => reset,
		clock => clock,
		branch => branch,
		offset => offset,
		read => read
	);

	clock <= not clock after clock_period / 2;

	process
	begin
		reset <= '0';
		wait for 3 * clock_period;
		branch <= '1';
		offset <= X"000002";
		wait for 2 * clock_period / 3;
		branch <= '0';
		wait for 2 * clock_period + clock_period / 3;
		branch <= '1';
		offset <= X"FFFFFB";
		wait for 2 * clock_period / 3;
		branch <= '0';
		wait for 5 * clock_period / 3;
		reset <= '1';
		wait;
	end process;
end tb;
