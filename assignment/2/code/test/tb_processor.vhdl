library ieee;
use ieee.std_logic_1164.all;

use work.MyTypes.all;

entity processor_tb is
end processor_tb;

architecture tb of processor_tb is
	signal clock: std_logic := '1';
	signal reset: std_logic := '1';

	constant clock_period: time := 1 ns;
begin
	CPU: entity work.processor port map (
		clock => clock,
		reset => reset
	);

	process
	begin
		reset <= '1';
		wait for clock_period;
		reset <= '0';
		wait;
	end process;

	clock <= not clock after clock_period / 2;
end tb;
