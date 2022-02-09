-- taken from piazza @163

library ieee;
use ieee.std_logic_1164.all;

package MyTypes is
	subtype word is std_logic_vector(31 downto 0);
	subtype hword is std_logic_vector(15 downto 0);
	subtype byte is std_logic_vector(7 downto 0);
	type optype is (andop, eor, sub, rsb, add, adc, sbc, rsc, tst, teq, cmp, cmn, orr, mov, bic, mvn);
end MyTypes;
