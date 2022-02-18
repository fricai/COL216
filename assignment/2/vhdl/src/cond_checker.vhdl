library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.MyTypes.all;

entity cond_checker is
	Port (
	N, Z, C, V: in std_logic;
	cond: in condtype;
	res: out std_logic);
end cond_checker;

architecture beh of cond_checker is
begin
	with cond select
		res <= Z when eq,
		       not Z when ne,
		       C when cs,
		       not C when cc,
		       N when mi,
		       not N when pl,
		       V when vs,
		       not V when vc,
		       C and (not Z) when hi,
		       (not C) or Z when ls,
		       not(N xor V) when ge, -- N = V
		       (N xor V) when lt, -- N != V
		       (not Z) and (not (N xor V)) when gt,
		       Z or (N xor V) when le,
		       '1' when al;
end beh;
