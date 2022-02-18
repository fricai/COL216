library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.MyTypes.all;

entity flag_circuit is
	Port (
	clock, enable, carry: in std_logic;
	DP_subclass: in DP_subclass_type;
	op1, op2: in std_logic;
	result: in word;
	N: out std_logic := '0';
	Z: out std_logic := '0';
	C: out std_logic := '0';
	V: out std_logic := '0');
end flag_circuit;

architecture beh of flag_circuit is
	signal res_b: std_logic;
begin
	res_b <= result(word_size - 1);

	-- for now, only change stuff for comp operations
	process(clock)
	begin
		if (enable = '1' and rising_edge(clock)) then
			if (DP_subclass = comp) then
				C <= carry;
				case result is
					when X"00000000" => Z <= '1';
					when others => Z <= '0';
				end case;
				N <= res_b;
				V <= op1 xor op2 xor res_b xor carry;
			end if;
		end if;
	end process;
end beh;
