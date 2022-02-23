library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.mytypes.all;
entity processor is
  port (
    clock, reset: in std_logic
  );
end processor;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is
  port (
    addr : in std_logic_vector (31 downto 0);
    write_enable : in std_logic_vector (3 downto 0);
    clock : in std_logic;
    data_in : in std_logic_vector (31 downto 0);
    data_out : out std_logic_vector (31 downto 0));
end entity data_memory;

architecture rtl of data_memory is
  signal n417_o : std_logic_vector (5 downto 0);
  signal n425_o : std_logic;
  signal n426_o : std_logic;
  signal n427_o : std_logic_vector (5 downto 0);
  signal n432_o : std_logic_vector (7 downto 0);
  signal n435_o : std_logic;
  signal n436_o : std_logic_vector (5 downto 0);
  signal n441_o : std_logic_vector (7 downto 0);
  signal n444_o : std_logic;
  signal n445_o : std_logic_vector (5 downto 0);
  signal n450_o : std_logic_vector (7 downto 0);
  signal n453_o : std_logic;
  signal n454_o : std_logic_vector (5 downto 0);
  signal n459_o : std_logic_vector (7 downto 0);
  signal n476_data : std_logic_vector (7 downto 0);
  signal n477_data : std_logic_vector (7 downto 0);
  signal n478_data : std_logic_vector (7 downto 0);
  signal n479_data : std_logic_vector (7 downto 0);
  signal n480_o : std_logic_vector (31 downto 0);
begin
  data_out <= n480_o;
  -- src/data_memory.vhdl:21:48
  n417_o <= addr (7 downto 2);
  -- src/data_memory.vhdl:26:20
  n425_o <= '1' when rising_edge (clock) else '0';
  -- src/data_memory.vhdl:28:48
  n426_o <= write_enable (0);
  -- src/data_memory.vhdl:29:68
  n427_o <= addr (7 downto 2);
  -- src/data_memory.vhdl:30:58
  n432_o <= data_in (7 downto 0);
  -- src/data_memory.vhdl:28:48
  n435_o <= write_enable (1);
  -- src/data_memory.vhdl:29:68
  n436_o <= addr (7 downto 2);
  -- src/data_memory.vhdl:30:58
  n441_o <= data_in (15 downto 8);
  -- src/data_memory.vhdl:28:48
  n444_o <= write_enable (2);
  -- src/data_memory.vhdl:29:68
  n445_o <= addr (7 downto 2);
  -- src/data_memory.vhdl:30:58
  n450_o <= data_in (23 downto 16);
  -- src/data_memory.vhdl:28:48
  n453_o <= write_enable (3);
  -- src/data_memory.vhdl:29:68
  n454_o <= addr (7 downto 2);
  -- src/data_memory.vhdl:30:58
  n459_o <= data_in (31 downto 24);
  -- src/data_memory.vhdl:21:23
  process (n417_o, clock) is
    type n472_oport_type is array (0 to 63)
      of std_logic_vector (7 downto 0);
    variable n472_oport : n472_oport_type;
  begin
    n476_data <= n472_oport(to_integer (unsigned (n417_o)));
    if rising_edge (clock) and (n426_o = '1') then
      n472_oport (to_integer (unsigned (n427_o))) := n432_o;
    end if;
  end process;
  -- src/data_memory.vhdl:21:23
  process (n417_o, clock) is
    type n473_oport_type is array (0 to 63)
      of std_logic_vector (7 downto 0);
    variable n473_oport : n473_oport_type;
  begin
    n477_data <= n473_oport(to_integer (unsigned (n417_o)));
    if rising_edge (clock) and (n435_o = '1') then
      n473_oport (to_integer (unsigned (n436_o))) := n441_o;
    end if;
  end process;
  -- src/data_memory.vhdl:29:43
  process (n417_o, clock) is
    type n474_oport_type is array (0 to 63)
      of std_logic_vector (7 downto 0);
    variable n474_oport : n474_oport_type;
  begin
    n478_data <= n474_oport(to_integer (unsigned (n417_o)));
    if rising_edge (clock) and (n444_o = '1') then
      n474_oport (to_integer (unsigned (n445_o))) := n450_o;
    end if;
  end process;
  -- src/data_memory.vhdl:29:43
  process (n417_o, clock) is
    type n475_oport_type is array (0 to 63)
      of std_logic_vector (7 downto 0);
    variable n475_oport : n475_oport_type;
  begin
    n479_data <= n475_oport(to_integer (unsigned (n417_o)));
    if rising_edge (clock) and (n453_o = '1') then
      n475_oport (to_integer (unsigned (n454_o))) := n459_o;
    end if;
  end process;
  -- src/data_memory.vhdl:21:24
  -- src/data_memory.vhdl:29:43
  -- src/data_memory.vhdl:29:43
  -- src/data_memory.vhdl:29:43
  -- src/data_memory.vhdl:29:43
  n480_o <= n479_data & n478_data & n477_data & n476_data;
  -- src/data_memory.vhdl:29:44
  -- src/data_memory.vhdl:29:44
  -- src/data_memory.vhdl:29:44
  -- src/data_memory.vhdl:29:44
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cond_checker is
  port (
    n : in std_logic;
    z : in std_logic;
    c : in std_logic;
    v : in std_logic;
    cond : in std_logic_vector (3 downto 0);
    res : out std_logic);
end entity cond_checker;

architecture rtl of cond_checker is
  signal n367_o : std_logic;
  signal n368_o : std_logic;
  signal n370_o : std_logic;
  signal n372_o : std_logic;
  signal n373_o : std_logic;
  signal n375_o : std_logic;
  signal n377_o : std_logic;
  signal n378_o : std_logic;
  signal n380_o : std_logic;
  signal n382_o : std_logic;
  signal n383_o : std_logic;
  signal n385_o : std_logic;
  signal n386_o : std_logic;
  signal n387_o : std_logic;
  signal n389_o : std_logic;
  signal n390_o : std_logic;
  signal n391_o : std_logic;
  signal n393_o : std_logic;
  signal n394_o : std_logic;
  signal n395_o : std_logic;
  signal n397_o : std_logic;
  signal n398_o : std_logic;
  signal n400_o : std_logic;
  signal n401_o : std_logic;
  signal n402_o : std_logic;
  signal n403_o : std_logic;
  signal n405_o : std_logic;
  signal n406_o : std_logic;
  signal n407_o : std_logic;
  signal n409_o : std_logic;
  signal n412_o : std_logic;
  signal n413_o : std_logic_vector (14 downto 0);
  signal n415_o : std_logic;
begin
  res <= n415_o;
  -- src/cond_checker.vhdl:17:25
  n367_o <= '1' when cond = "0000" else '0';
  -- src/cond_checker.vhdl:18:23
  n368_o <= not z;
  -- src/cond_checker.vhdl:18:29
  n370_o <= '1' when cond = "0001" else '0';
  -- src/cond_checker.vhdl:19:25
  n372_o <= '1' when cond = "0010" else '0';
  -- src/cond_checker.vhdl:20:23
  n373_o <= not c;
  -- src/cond_checker.vhdl:20:29
  n375_o <= '1' when cond = "0011" else '0';
  -- src/cond_checker.vhdl:21:25
  n377_o <= '1' when cond = "0100" else '0';
  -- src/cond_checker.vhdl:22:23
  n378_o <= not n;
  -- src/cond_checker.vhdl:22:29
  n380_o <= '1' when cond = "0101" else '0';
  -- src/cond_checker.vhdl:23:25
  n382_o <= '1' when cond = "0110" else '0';
  -- src/cond_checker.vhdl:24:23
  n383_o <= not v;
  -- src/cond_checker.vhdl:24:29
  n385_o <= '1' when cond = "0111" else '0';
  -- src/cond_checker.vhdl:25:30
  n386_o <= not z;
  -- src/cond_checker.vhdl:25:25
  n387_o <= c and n386_o;
  -- src/cond_checker.vhdl:25:37
  n389_o <= '1' when cond = "1000" else '0';
  -- src/cond_checker.vhdl:26:24
  n390_o <= not c;
  -- src/cond_checker.vhdl:26:31
  n391_o <= n390_o or z;
  -- src/cond_checker.vhdl:26:36
  n393_o <= '1' when cond = "1001" else '0';
  -- src/cond_checker.vhdl:27:29
  n394_o <= n xor v;
  -- src/cond_checker.vhdl:27:23
  n395_o <= not n394_o;
  -- src/cond_checker.vhdl:27:36
  n397_o <= '1' when cond = "1010" else '0';
  -- src/cond_checker.vhdl:28:26
  n398_o <= n xor v;
  -- src/cond_checker.vhdl:28:33
  n400_o <= '1' when cond = "1011" else '0';
  -- src/cond_checker.vhdl:29:24
  n401_o <= not z;
  -- src/cond_checker.vhdl:29:38
  n402_o <= n xnor v;
  -- src/cond_checker.vhdl:29:31
  n403_o <= n401_o and n402_o;
  -- src/cond_checker.vhdl:29:46
  n405_o <= '1' when cond = "1100" else '0';
  -- src/cond_checker.vhdl:30:31
  n406_o <= n xor v;
  -- src/cond_checker.vhdl:30:25
  n407_o <= z or n406_o;
  -- src/cond_checker.vhdl:30:38
  n409_o <= '1' when cond = "1101" else '0';
  -- src/cond_checker.vhdl:31:27
  n412_o <= '1' when cond = "1110" else '0';
  n413_o <= n412_o & n409_o & n405_o & n400_o & n397_o & n393_o & n389_o & n385_o & n382_o & n380_o & n377_o & n375_o & n372_o & n370_o & n367_o;
  -- src/cond_checker.vhdl:16:8
  with n413_o select n415_o <=
    '1' when "100000000000000",
    n407_o when "010000000000000",
    n403_o when "001000000000000",
    n398_o when "000100000000000",
    n395_o when "000010000000000",
    n391_o when "000001000000000",
    n387_o when "000000100000000",
    n383_o when "000000010000000",
    v when "000000001000000",
    n378_o when "000000000100000",
    n when "000000000010000",
    n373_o when "000000000001000",
    c when "000000000000100",
    n368_o when "000000000000010",
    z when "000000000000001",
    'X' when others;
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flag_circuit is
  port (
    clock : in std_logic;
    enable : in std_logic;
    alu_carry : in std_logic;
    shifter_carry : in std_logic;
    dp_subclass : in std_logic_vector (2 downto 0);
    operation : in std_logic_vector (3 downto 0);
    s_bit : in std_logic;
    op1 : in std_logic;
    op2 : in std_logic;
    result : in std_logic_vector (31 downto 0);
    n : out std_logic;
    z : out std_logic;
    c : out std_logic;
    v : out std_logic);
end entity flag_circuit;

architecture rtl of flag_circuit is
  signal res_b : std_logic;
  signal n314_o : std_logic;
  signal n317_o : std_logic;
  signal n318_o : std_logic;
  signal n320_o : std_logic;
  signal n322_o : std_logic;
  signal n325_o : std_logic;
  signal n326_o : std_logic;
  signal n327_o : std_logic;
  signal n328_o : std_logic;
  signal n329_o : std_logic;
  signal n330_o : std_logic;
  signal n331_o : std_logic;
  signal n332_o : std_logic;
  signal n333_o : std_logic;
  signal n335_o : std_logic;
  signal n336_o : std_logic;
  signal n337_o : std_logic;
  signal n338_o : std_logic;
  signal n339_o : std_logic;
  signal n340_o : std_logic;
  signal n341_o : std_logic;
  signal n342_o : std_logic;
  signal n343_o : std_logic;
  signal n344_o : std_logic;
  signal n354_o : std_logic;
  signal n355_o : std_logic;
  signal n356_q : std_logic := '0';
  signal n357_o : std_logic;
  signal n358_o : std_logic;
  signal n359_q : std_logic := '0';
  signal n360_o : std_logic;
  signal n361_o : std_logic;
  signal n362_q : std_logic := '0';
  signal n363_o : std_logic;
  signal n364_q : std_logic := '0';
begin
  n <= n356_q;
  z <= n359_q;
  c <= n362_q;
  v <= n364_q;
  -- src/flag_circuit.vhdl:22:15
  res_b <= n314_o; -- (signal)
  -- src/flag_circuit.vhdl:25:23
  n314_o <= result (31);
  -- src/flag_circuit.vhdl:30:37
  n317_o <= '1' when rising_edge (clock) else '0';
  -- src/flag_circuit.vhdl:30:33
  n318_o <= enable and n320_o;
  -- src/flag_circuit.vhdl:31:40
  n320_o <= '1' when dp_subclass = "010" else '0';
  -- src/flag_circuit.vhdl:34:40
  n322_o <= '1' when result = "00000000000000000000000000000000" else '0';
  -- src/flag_circuit.vhdl:33:32
  with n322_o select n325_o <=
    '1' when '1',
    '0' when others;
  -- src/flag_circuit.vhdl:40:58
  n326_o <= op1 and op2;
  -- src/flag_circuit.vhdl:40:71
  n327_o <= not res_b;
  -- src/flag_circuit.vhdl:40:66
  n328_o <= n326_o and n327_o;
  -- src/flag_circuit.vhdl:41:55
  n329_o <= not op1;
  -- src/flag_circuit.vhdl:41:69
  n330_o <= not op2;
  -- src/flag_circuit.vhdl:41:64
  n331_o <= n329_o and n330_o;
  -- src/flag_circuit.vhdl:41:78
  n332_o <= n331_o and res_b;
  -- src/flag_circuit.vhdl:40:83
  n333_o <= n328_o or n332_o;
  -- src/flag_circuit.vhdl:39:40
  n335_o <= '1' when operation = "1010" else '0';
  -- src/flag_circuit.vhdl:43:63
  n336_o <= not op2;
  -- src/flag_circuit.vhdl:43:58
  n337_o <= op1 and n336_o;
  -- src/flag_circuit.vhdl:43:77
  n338_o <= not res_b;
  -- src/flag_circuit.vhdl:43:72
  n339_o <= n337_o and n338_o;
  -- src/flag_circuit.vhdl:44:55
  n340_o <= not op1;
  -- src/flag_circuit.vhdl:44:64
  n341_o <= n340_o and op2;
  -- src/flag_circuit.vhdl:44:72
  n342_o <= n341_o and res_b;
  -- src/flag_circuit.vhdl:43:89
  n343_o <= n339_o or n342_o;
  -- src/flag_circuit.vhdl:38:32
  with n335_o select n344_o <=
    n333_o when '1',
    n343_o when others;
  -- src/flag_circuit.vhdl:30:16
  n354_o <= enable and n320_o;
  -- src/flag_circuit.vhdl:30:16
  n355_o <= n356_q when n354_o = '0' else res_b;
  -- src/flag_circuit.vhdl:30:16
  process (clock)
  begin
    if rising_edge (clock) then
      n356_q <= n355_o;
    end if;
  end process;
  -- src/flag_circuit.vhdl:30:16
  n357_o <= enable and n320_o;
  -- src/flag_circuit.vhdl:30:16
  n358_o <= n359_q when n357_o = '0' else n325_o;
  -- src/flag_circuit.vhdl:30:16
  process (clock)
  begin
    if rising_edge (clock) then
      n359_q <= n358_o;
    end if;
  end process;
  -- src/flag_circuit.vhdl:30:16
  n360_o <= enable and n320_o;
  -- src/flag_circuit.vhdl:30:16
  n361_o <= n362_q when n360_o = '0' else alu_carry;
  -- src/flag_circuit.vhdl:30:16
  process (clock)
  begin
    if rising_edge (clock) then
      n362_q <= n361_o;
    end if;
  end process;
  -- src/flag_circuit.vhdl:30:33
  n363_o <= n364_q when n318_o = '0' else n344_o;
  -- src/flag_circuit.vhdl:30:16
  process (clock)
  begin
    if rising_edge (clock) then
      n364_q <= n363_o;
    end if;
  end process;
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  port (
    op1 : in std_logic_vector (31 downto 0);
    op2 : in std_logic_vector (31 downto 0);
    instr : in std_logic_vector (3 downto 0);
    carry_in : in std_logic;
    result : out std_logic_vector (31 downto 0);
    carry_out : out std_logic);
end entity alu;

architecture rtl of alu is
  signal tmp : std_logic_vector (32 downto 0);
  signal op1_u : std_logic_vector (32 downto 0);
  signal op2_u : std_logic_vector (32 downto 0);
  signal nop1_u : std_logic_vector (32 downto 0);
  signal nop2_u : std_logic_vector (32 downto 0);
  signal n225_o : std_logic_vector (32 downto 0);
  signal n227_o : std_logic_vector (32 downto 0);
  signal n228_o : std_logic_vector (31 downto 0);
  signal n230_o : std_logic_vector (32 downto 0);
  signal n231_o : std_logic_vector (31 downto 0);
  signal n233_o : std_logic_vector (32 downto 0);
  signal n234_o : std_logic_vector (32 downto 0);
  signal n236_o : std_logic;
  signal n237_o : std_logic_vector (32 downto 0);
  signal n239_o : std_logic;
  signal n240_o : std_logic_vector (32 downto 0);
  signal n243_o : std_logic_vector (32 downto 0);
  signal n245_o : std_logic;
  signal n246_o : std_logic_vector (32 downto 0);
  signal n249_o : std_logic_vector (32 downto 0);
  signal n251_o : std_logic;
  signal n252_o : std_logic_vector (32 downto 0);
  signal n254_o : std_logic;
  signal n255_o : std_logic_vector (32 downto 0);
  signal n257_o : std_logic;
  signal n258_o : std_logic_vector (32 downto 0);
  signal n259_o : std_logic_vector (32 downto 0);
  signal n261_o : std_logic;
  signal n262_o : std_logic_vector (32 downto 0);
  signal n264_o : std_logic;
  signal n265_o : std_logic_vector (32 downto 0);
  signal n266_o : std_logic_vector (32 downto 0);
  signal n268_o : std_logic;
  signal n269_o : std_logic_vector (32 downto 0);
  signal n271_o : std_logic;
  signal n272_o : std_logic_vector (32 downto 0);
  signal n273_o : std_logic_vector (32 downto 0);
  signal n275_o : std_logic;
  signal n276_o : std_logic_vector (32 downto 0);
  signal n278_o : std_logic;
  signal n279_o : std_logic_vector (32 downto 0);
  signal n281_o : std_logic;
  signal n282_o : std_logic_vector (32 downto 0);
  signal n285_o : std_logic_vector (32 downto 0);
  signal n287_o : std_logic;
  signal n288_o : std_logic_vector (32 downto 0);
  signal n290_o : std_logic;
  signal n291_o : std_logic_vector (32 downto 0);
  signal n293_o : std_logic;
  signal n295_o : std_logic;
  signal n296_o : std_logic_vector (32 downto 0);
  signal n298_o : std_logic;
  signal n300_o : std_logic;
  signal n301_o : std_logic_vector (15 downto 0);
  signal n303_o : std_logic_vector (32 downto 0);
  signal n304_o : std_logic_vector (31 downto 0);
  signal n305_o : std_logic;
begin
  result <= n304_o;
  carry_out <= n305_o;
  -- src/alu.vhdl:17:15
  tmp <= n303_o; -- (signal)
  -- src/alu.vhdl:18:15
  op1_u <= n225_o; -- (signal)
  -- src/alu.vhdl:18:22
  op2_u <= n227_o; -- (signal)
  -- src/alu.vhdl:18:29
  nop1_u <= n230_o; -- (signal)
  -- src/alu.vhdl:18:37
  nop2_u <= n233_o; -- (signal)
  -- src/alu.vhdl:20:30
  n225_o <= '0' & op1;
  -- src/alu.vhdl:21:30
  n227_o <= '0' & op2;
  -- src/alu.vhdl:22:34
  n228_o <= not op1;
  -- src/alu.vhdl:22:31
  n230_o <= '0' & n228_o;
  -- src/alu.vhdl:23:34
  n231_o <= not op2;
  -- src/alu.vhdl:23:31
  n233_o <= '0' & n231_o;
  -- src/alu.vhdl:25:29
  n234_o <= op1_u and op2_u;
  -- src/alu.vhdl:25:39
  n236_o <= '1' when instr = "0000" else '0';
  -- src/alu.vhdl:26:29
  n237_o <= op1_u xor op2_u;
  -- src/alu.vhdl:26:39
  n239_o <= '1' when instr = "0001" else '0';
  -- src/alu.vhdl:27:29
  n240_o <= std_logic_vector (unsigned (op1_u) + unsigned (nop2_u));
  -- src/alu.vhdl:27:38
  n243_o <= std_logic_vector (unsigned (n240_o) + unsigned'("000000000000000000000000000000001"));
  -- src/alu.vhdl:27:55
  n245_o <= '1' when instr = "0010" else '0';
  -- src/alu.vhdl:28:30
  n246_o <= std_logic_vector (unsigned (nop1_u) + unsigned (op2_u));
  -- src/alu.vhdl:28:38
  n249_o <= std_logic_vector (unsigned (n246_o) + unsigned'("000000000000000000000000000000001"));
  -- src/alu.vhdl:28:55
  n251_o <= '1' when instr = "0011" else '0';
  -- src/alu.vhdl:29:29
  n252_o <= std_logic_vector (unsigned (op1_u) + unsigned (op2_u));
  -- src/alu.vhdl:29:37
  n254_o <= '1' when instr = "0100" else '0';
  -- src/alu.vhdl:30:29
  n255_o <= std_logic_vector (unsigned (op1_u) + unsigned (op2_u));
  -- src/alu.vhdl:30:52
  n257_o <= carry_in;  --  concat
  -- src/alu.vhdl:30:37
  n258_o <= "00000000000000000000000000000000" & n257_o;  --  uext
  -- src/alu.vhdl:30:37
  n259_o <= std_logic_vector (unsigned (n255_o) + unsigned (n258_o));
  -- src/alu.vhdl:30:64
  n261_o <= '1' when instr = "0101" else '0';
  -- src/alu.vhdl:31:29
  n262_o <= std_logic_vector (unsigned (op1_u) + unsigned (nop2_u));
  -- src/alu.vhdl:31:53
  n264_o <= carry_in;  --  concat
  -- src/alu.vhdl:31:38
  n265_o <= "00000000000000000000000000000000" & n264_o;  --  uext
  -- src/alu.vhdl:31:38
  n266_o <= std_logic_vector (unsigned (n262_o) + unsigned (n265_o));
  -- src/alu.vhdl:31:65
  n268_o <= '1' when instr = "0110" else '0';
  -- src/alu.vhdl:32:30
  n269_o <= std_logic_vector (unsigned (nop1_u) + unsigned (op2_u));
  -- src/alu.vhdl:32:53
  n271_o <= carry_in;  --  concat
  -- src/alu.vhdl:32:38
  n272_o <= "00000000000000000000000000000000" & n271_o;  --  uext
  -- src/alu.vhdl:32:38
  n273_o <= std_logic_vector (unsigned (n269_o) + unsigned (n272_o));
  -- src/alu.vhdl:32:65
  n275_o <= '1' when instr = "0111" else '0';
  -- src/alu.vhdl:33:29
  n276_o <= op1_u and op2_u;
  -- src/alu.vhdl:33:39
  n278_o <= '1' when instr = "1000" else '0';
  -- src/alu.vhdl:34:29
  n279_o <= op1_u xor op2_u;
  -- src/alu.vhdl:34:39
  n281_o <= '1' when instr = "1001" else '0';
  -- src/alu.vhdl:35:29
  n282_o <= std_logic_vector (unsigned (op1_u) + unsigned (nop2_u));
  -- src/alu.vhdl:35:38
  n285_o <= std_logic_vector (unsigned (n282_o) + unsigned'("000000000000000000000000000000001"));
  -- src/alu.vhdl:35:55
  n287_o <= '1' when instr = "1010" else '0';
  -- src/alu.vhdl:36:29
  n288_o <= std_logic_vector (unsigned (op1_u) + unsigned (op2_u));
  -- src/alu.vhdl:36:37
  n290_o <= '1' when instr = "1011" else '0';
  -- src/alu.vhdl:37:29
  n291_o <= op1_u or op2_u;
  -- src/alu.vhdl:37:38
  n293_o <= '1' when instr = "1100" else '0';
  -- src/alu.vhdl:38:29
  n295_o <= '1' when instr = "1101" else '0';
  -- src/alu.vhdl:39:29
  n296_o <= op1_u and nop2_u;
  -- src/alu.vhdl:39:40
  n298_o <= '1' when instr = "1110" else '0';
  -- src/alu.vhdl:40:30
  n300_o <= '1' when instr = "1111" else '0';
  n301_o <= n300_o & n298_o & n295_o & n293_o & n290_o & n287_o & n281_o & n278_o & n275_o & n268_o & n261_o & n254_o & n251_o & n245_o & n239_o & n236_o;
  -- src/alu.vhdl:24:8
  with n301_o select n303_o <=
    nop2_u when "1000000000000000",
    n296_o when "0100000000000000",
    op2_u when "0010000000000000",
    n291_o when "0001000000000000",
    n288_o when "0000100000000000",
    n285_o when "0000010000000000",
    n279_o when "0000001000000000",
    n276_o when "0000000100000000",
    n273_o when "0000000010000000",
    n266_o when "0000000001000000",
    n259_o when "0000000000100000",
    n252_o when "0000000000010000",
    n249_o when "0000000000001000",
    n243_o when "0000000000000100",
    n237_o when "0000000000000010",
    n234_o when "0000000000000001",
    (32 downto 0 => 'X') when others;
  -- src/alu.vhdl:41:38
  n304_o <= tmp (31 downto 0);
  -- src/alu.vhdl:42:24
  n305_o <= tmp (32);
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file is
  port (
    read_addr1 : in std_logic_vector (3 downto 0);
    read_addr2 : in std_logic_vector (3 downto 0);
    write_addr : in std_logic_vector (3 downto 0);
    data_in : in std_logic_vector (31 downto 0);
    write_enable : in std_logic;
    clock : in std_logic;
    data_out1 : out std_logic_vector (31 downto 0);
    data_out2 : out std_logic_vector (31 downto 0));
end entity reg_file;

architecture rtl of reg_file is
  signal n207_o : std_logic;
  signal n219_data : std_logic_vector (31 downto 0);
  signal n220_data : std_logic_vector (31 downto 0);
begin
  data_out1 <= n220_data;
  data_out2 <= n219_data;
  -- src/reg_file.vhdl:25:20
  n207_o <= '1' when rising_edge (clock) else '0';
  -- src/reg_file.vhdl:20:24
  process (read_addr2, read_addr1, clock) is
    type n218_oport_type is array (0 to 15)
      of std_logic_vector (31 downto 0);
    variable n218_oport : n218_oport_type;
  begin
    n219_data <= n218_oport(to_integer (unsigned (read_addr2)));
    n220_data <= n218_oport(to_integer (unsigned (read_addr1)));
    if rising_edge (clock) and (write_enable = '1') then
      n218_oport (to_integer (unsigned (write_addr))) := data_in;
    end if;
  end process;
  -- src/reg_file.vhdl:21:25
  -- src/reg_file.vhdl:20:25
  -- src/reg_file.vhdl:26:28
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
  port (
    instruction : in std_logic_vector (31 downto 0);
    instr_class : out std_logic_vector (2 downto 0);
    operation : out std_logic_vector (3 downto 0);
    dp_subclass : out std_logic_vector (2 downto 0);
    dp_operand_src : out std_logic;
    load_store : out std_logic;
    dt_offset_sign : out std_logic;
    cond : out std_logic_vector (3 downto 0);
    s_bit : out std_logic);
end entity decoder;

architecture rtl of decoder is
  signal n123_o : std_logic_vector (1 downto 0);
  signal n126_o : std_logic;
  signal n129_o : std_logic;
  signal n132_o : std_logic;
  signal n134_o : std_logic_vector (2 downto 0);
  signal n135_o : std_logic_vector (2 downto 0);
  signal n136_o : std_logic_vector (3 downto 0);
  signal n139_o : std_logic_vector (3 downto 0);
  signal n143_o : std_logic_vector (2 downto 0);
  signal n146_o : std_logic;
  signal n148_o : std_logic;
  signal n149_o : std_logic;
  signal n151_o : std_logic;
  signal n152_o : std_logic;
  signal n155_o : std_logic;
  signal n157_o : std_logic;
  signal n158_o : std_logic;
  signal n160_o : std_logic;
  signal n161_o : std_logic;
  signal n164_o : std_logic;
  signal n166_o : std_logic_vector (2 downto 0);
  signal n167_o : std_logic_vector (2 downto 0);
  signal n169_o : std_logic;
  signal n170_o : std_logic;
  signal n171_o : std_logic;
  signal n174_o : std_logic;
  signal n175_o : std_logic;
  signal n178_o : std_logic;
  signal n179_o : std_logic;
  signal n181_o : std_logic_vector (3 downto 0);
  signal n184_o : std_logic_vector (3 downto 0);
  signal n188_o : std_logic;
  signal n190_data : std_logic_vector (3 downto 0);
  signal n192_data : std_logic_vector (3 downto 0);
begin
  instr_class <= n135_o;
  operation <= n190_data;
  dp_subclass <= n167_o;
  dp_operand_src <= n171_o;
  load_store <= n175_o;
  dt_offset_sign <= n179_o;
  cond <= n192_data;
  s_bit <= n188_o;
  -- src/decoder.vhdl:30:24
  n123_o <= instruction (27 downto 26);
  -- src/decoder.vhdl:31:34
  n126_o <= '1' when n123_o = "00" else '0';
  -- src/decoder.vhdl:32:34
  n129_o <= '1' when n123_o = "01" else '0';
  -- src/decoder.vhdl:33:35
  n132_o <= '1' when n123_o = "10" else '0';
  n134_o <= n132_o & n129_o & n126_o;
  -- src/decoder.vhdl:30:8
  with n134_o select n135_o <=
    "011" when "100",
    "001" when "010",
    "000" when "001",
    "100" when others;
  -- src/decoder.vhdl:35:60
  n136_o <= instruction (24 downto 21);
  -- src/decoder.vhdl:35:28
  n139_o <= std_logic_vector (unsigned'("1111") - unsigned (n136_o));
  -- src/decoder.vhdl:37:24
  n143_o <= instruction (24 downto 22);
  -- src/decoder.vhdl:38:37
  n146_o <= '1' when n143_o = "001" else '0';
  -- src/decoder.vhdl:38:48
  n148_o <= '1' when n143_o = "010" else '0';
  -- src/decoder.vhdl:38:48
  n149_o <= n146_o or n148_o;
  -- src/decoder.vhdl:38:56
  n151_o <= '1' when n143_o = "011" else '0';
  -- src/decoder.vhdl:38:56
  n152_o <= n149_o or n151_o;
  -- src/decoder.vhdl:39:37
  n155_o <= '1' when n143_o = "000" else '0';
  -- src/decoder.vhdl:39:48
  n157_o <= '1' when n143_o = "110" else '0';
  -- src/decoder.vhdl:39:48
  n158_o <= n155_o or n157_o;
  -- src/decoder.vhdl:39:56
  n160_o <= '1' when n143_o = "111" else '0';
  -- src/decoder.vhdl:39:56
  n161_o <= n158_o or n160_o;
  -- src/decoder.vhdl:40:36
  n164_o <= '1' when n143_o = "101" else '0';
  n166_o <= n164_o & n161_o & n152_o;
  -- src/decoder.vhdl:37:8
  with n166_o select n167_o <=
    "010" when "100",
    "001" when "010",
    "000" when "001",
    "011" when others;
  -- src/decoder.vhdl:43:46
  n169_o <= instruction (25);
  -- src/decoder.vhdl:43:51
  n170_o <= not n169_o;
  -- src/decoder.vhdl:43:30
  n171_o <= '1' when n170_o = '0' else '0';
  -- src/decoder.vhdl:44:43
  n174_o <= instruction (20);
  -- src/decoder.vhdl:44:27
  n175_o <= '1' when n174_o = '0' else '0';
  -- src/decoder.vhdl:45:47
  n178_o <= instruction (23);
  -- src/decoder.vhdl:45:31
  n179_o <= '1' when n178_o = '0' else '0';
  -- src/decoder.vhdl:48:57
  n181_o <= instruction (31 downto 28);
  -- src/decoder.vhdl:48:25
  n184_o <= std_logic_vector (unsigned'("1110") - unsigned (n181_o));
  -- src/decoder.vhdl:50:28
  n188_o <= instruction (20);
  -- src/decoder.vhdl:19:21
  process (n139_o) is
    type n189_oport_type is array (0 to 15)
      of std_logic_vector (3 downto 0);
    variable n189_oport : n189_oport_type :=
      (15 => "0000",
       14 => "0001",
       13 => "0010",
       12 => "0011",
       11 => "0100",
       10 => "0101",
       9 => "0110",
       8 => "0111",
       7 => "1000",
       6 => "1001",
       5 => "1010",
       4 => "1011",
       3 => "1100",
       2 => "1101",
       1 => "1110",
       0 => "1111");
  begin
    n190_data <= n189_oport(to_integer (unsigned (n139_o)));
  end process;
  -- src/decoder.vhdl:35:29
  -- src/decoder.vhdl:35:28
  process (n184_o) is
    type n191_oport_type is array (0 to 14)
      of std_logic_vector (3 downto 0);
    variable n191_oport : n191_oport_type :=
      (14 => "0000",
       13 => "0001",
       12 => "0010",
       11 => "0011",
       10 => "0100",
       9 => "0101",
       8 => "0110",
       7 => "0111",
       6 => "1000",
       5 => "1001",
       4 => "1010",
       3 => "1011",
       2 => "1100",
       1 => "1101",
       0 => "1110");
  begin
    n192_data <= n191_oport(to_integer (unsigned (n184_o)));
  end process;
  -- src/decoder.vhdl:48:26
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_memory is
  port (
    addr : in std_logic_vector (31 downto 0);
    data_out : out std_logic_vector (31 downto 0));
end entity program_memory;

architecture rtl of program_memory is
  signal mem : std_logic_vector (2047 downto 0);
  signal n107_o : std_logic_vector (5 downto 0);
  signal n110_o : std_logic_vector (5 downto 0);
  signal n114_data : std_logic_vector (31 downto 0);
begin
  data_out <= n114_data;
  -- src/program_memory.vhdl:14:15
  mem <= "11100011101000000000000000010000111000111010000000010000000001011110010110000000000100000000000011100010100000010001000000000010111001011000000000010000000001001110010110010000001000000000000011100101100100000011000000000100111000000100001101000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"; -- (isignal)
  -- src/program_memory.vhdl:37:48
  n107_o <= addr (7 downto 2);
  -- src/program_memory.vhdl:37:23
  n110_o <= std_logic_vector (unsigned'("111111") - unsigned (n107_o));
  -- src/program_memory.vhdl:9:20
  process (n110_o) is
    type n113_oport_type is array (0 to 63)
      of std_logic_vector (31 downto 0);
    variable n113_oport : n113_oport_type :=
      (63 => "11100011101000000000000000010000",
       62 => "11100011101000000001000000000101",
       61 => "11100101100000000001000000000000",
       60 => "11100010100000010001000000000010",
       59 => "11100101100000000001000000000100",
       58 => "11100101100100000010000000000000",
       57 => "11100101100100000011000000000100",
       56 => "11100000010000110100000000000010",
       55 => "00000000000000000000000000000000",
       54 => "00000000000000000000000000000000",
       53 => "00000000000000000000000000000000",
       52 => "00000000000000000000000000000000",
       51 => "00000000000000000000000000000000",
       50 => "00000000000000000000000000000000",
       49 => "00000000000000000000000000000000",
       48 => "00000000000000000000000000000000",
       47 => "00000000000000000000000000000000",
       46 => "00000000000000000000000000000000",
       45 => "00000000000000000000000000000000",
       44 => "00000000000000000000000000000000",
       43 => "00000000000000000000000000000000",
       42 => "00000000000000000000000000000000",
       41 => "00000000000000000000000000000000",
       40 => "00000000000000000000000000000000",
       39 => "00000000000000000000000000000000",
       38 => "00000000000000000000000000000000",
       37 => "00000000000000000000000000000000",
       36 => "00000000000000000000000000000000",
       35 => "00000000000000000000000000000000",
       34 => "00000000000000000000000000000000",
       33 => "00000000000000000000000000000000",
       32 => "00000000000000000000000000000000",
       31 => "00000000000000000000000000000000",
       30 => "00000000000000000000000000000000",
       29 => "00000000000000000000000000000000",
       28 => "00000000000000000000000000000000",
       27 => "00000000000000000000000000000000",
       26 => "00000000000000000000000000000000",
       25 => "00000000000000000000000000000000",
       24 => "00000000000000000000000000000000",
       23 => "00000000000000000000000000000000",
       22 => "00000000000000000000000000000000",
       21 => "00000000000000000000000000000000",
       20 => "00000000000000000000000000000000",
       19 => "00000000000000000000000000000000",
       18 => "00000000000000000000000000000000",
       17 => "00000000000000000000000000000000",
       16 => "00000000000000000000000000000000",
       15 => "00000000000000000000000000000000",
       14 => "00000000000000000000000000000000",
       13 => "00000000000000000000000000000000",
       12 => "00000000000000000000000000000000",
       11 => "00000000000000000000000000000000",
       10 => "00000000000000000000000000000000",
       9 => "00000000000000000000000000000000",
       8 => "00000000000000000000000000000000",
       7 => "00000000000000000000000000000000",
       6 => "00000000000000000000000000000000",
       5 => "00000000000000000000000000000000",
       4 => "00000000000000000000000000000000",
       3 => "00000000000000000000000000000000",
       2 => "00000000000000000000000000000000",
       1 => "00000000000000000000000000000000",
       0 => "00000000000000000000000000000000");
  begin
    n114_data <= n113_oport(to_integer (unsigned (n110_o)));
  end process;
  -- src/program_memory.vhdl:37:24
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
  port (
    reset : in std_logic;
    clock : in std_logic;
    branch : in std_logic;
    offset : in std_logic_vector (23 downto 0);
    read : out std_logic_vector (31 downto 0));
end entity program_counter;

architecture rtl of program_counter is
  signal pc : std_logic_vector (31 downto 0);
  signal n87_o : std_logic;
  signal n89_o : std_logic_vector (31 downto 0);
  signal n91_o : std_logic;
  signal n93_o : std_logic_vector (31 downto 0);
  signal n95_o : std_logic_vector (25 downto 0);
  signal n96_o : std_logic_vector (31 downto 0);
  signal n97_o : std_logic_vector (31 downto 0);
  signal n98_o : std_logic_vector (31 downto 0);
  signal n103_q : std_logic_vector (31 downto 0);
begin
  read <= pc;
  -- src/program_counter.vhdl:15:15
  pc <= n103_q; -- (signal)
  -- src/program_counter.vhdl:23:23
  n87_o <= '1' when rising_edge (clock) else '0';
  -- src/program_counter.vhdl:25:80
  n89_o <= std_logic_vector (unsigned (pc) + unsigned'("00000000000000000000000000000100"));
  -- src/program_counter.vhdl:25:32
  n91_o <= '1' when branch = '0' else '0';
  -- src/program_counter.vhdl:26:83
  n93_o <= std_logic_vector (unsigned (pc) + unsigned'("00000000000000000000000000001000"));
  -- src/program_counter.vhdl:27:70
  n95_o <= offset & "00";
  -- src/program_counter.vhdl:27:49
  n96_o <= std_logic_vector (resize (signed (n95_o), 32));  --  sext
  -- src/program_counter.vhdl:26:87
  n97_o <= std_logic_vector (unsigned (n93_o) + unsigned (n96_o));
  -- src/program_counter.vhdl:24:24
  with n91_o select n98_o <=
    n89_o when '1',
    n97_o when others;
  -- src/program_counter.vhdl:23:16
  process (clock, reset)
  begin
    if reset = '1' then
      n103_q <= "00000000000000000000000000000000";
    elsif rising_edge (clock) then
      n103_q <= n98_o;
    end if;
  end process;
end rtl;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture rtl of processor is
  signal wrap_clock: std_logic;
  signal wrap_reset: std_logic;
  signal branch_offset : std_logic_vector (23 downto 0);
  signal branch : std_logic;
  signal pc_addr : std_logic_vector (31 downto 0);
  signal instruction : std_logic_vector (31 downto 0);
  signal instr_class : std_logic_vector (2 downto 0);
  signal operation : std_logic_vector (3 downto 0);
  signal dp_subclass : std_logic_vector (2 downto 0);
  signal dp_operand_src : std_logic;
  signal load_store : std_logic;
  signal dt_offset_sign : std_logic;
  signal cond_field : std_logic_vector (3 downto 0);
  signal reg_addr2 : std_logic_vector (3 downto 0);
  signal reg_in : std_logic_vector (31 downto 0);
  signal reg_out1 : std_logic_vector (31 downto 0);
  signal reg_out2 : std_logic_vector (31 downto 0);
  signal reg_en : std_logic;
  signal operand1 : std_logic_vector (31 downto 0);
  signal operand2 : std_logic_vector (31 downto 0);
  signal alu_out : std_logic_vector (31 downto 0);
  signal alu_carry : std_logic;
  signal n_flag : std_logic;
  signal z_flag : std_logic;
  signal c_flag : std_logic;
  signal v_flag : std_logic;
  signal f_en : std_logic;
  signal cond_true : std_logic;
  signal dm_en : std_logic_vector (3 downto 0);
  signal dm_out : std_logic_vector (31 downto 0);
  signal rd : std_logic_vector (3 downto 0);
  signal rn : std_logic_vector (3 downto 0);
  signal rm : std_logic_vector (3 downto 0);
  signal alu_op : std_logic_vector (3 downto 0);
  signal s_bit : std_logic;
  signal pc_read : std_logic_vector (31 downto 0);
  signal n1_o : std_logic_vector (23 downto 0);
  signal n4_o : std_logic;
  signal n5_o : std_logic;
  signal n6_o : std_logic;
  signal im_data_out : std_logic_vector (31 downto 0);
  signal id_instr_class : std_logic_vector (2 downto 0);
  signal id_operation : std_logic_vector (3 downto 0);
  signal id_dp_subclass : std_logic_vector (2 downto 0);
  signal id_dp_operand_src : std_logic;
  signal id_load_store : std_logic;
  signal id_dt_offset_sign : std_logic;
  signal id_cond : std_logic_vector (3 downto 0);
  signal id_s_bit : std_logic;
  signal n17_o : std_logic_vector (3 downto 0);
  signal n18_o : std_logic_vector (3 downto 0);
  signal n19_o : std_logic_vector (3 downto 0);
  signal n21_o : std_logic;
  signal n22_o : std_logic_vector (3 downto 0);
  signal rf_data_out1 : std_logic_vector (31 downto 0);
  signal rf_data_out2 : std_logic_vector (31 downto 0);
  signal n26_o : std_logic;
  signal n27_o : std_logic_vector (31 downto 0);
  signal n30_o : std_logic;
  signal n32_o : std_logic;
  signal n33_o : std_logic;
  signal n35_o : std_logic;
  signal n37_o : std_logic;
  signal n39_o : std_logic;
  signal n40_o : std_logic;
  signal n41_o : std_logic;
  signal n42_o : std_logic;
  signal n43_o : std_logic;
  signal n45_o : std_logic_vector (11 downto 0);
  signal n46_o : std_logic_vector (31 downto 0);
  signal n48_o : std_logic;
  signal n50_o : std_logic;
  signal n51_o : std_logic;
  signal n52_o : std_logic_vector (31 downto 0);
  signal n54_o : std_logic;
  signal n55_o : std_logic_vector (3 downto 0);
  signal n58_o : std_logic;
  signal n59_o : std_logic_vector (3 downto 0);
  signal alu_result : std_logic_vector (31 downto 0);
  signal alu_carry_out : std_logic;
  signal n64_o : std_logic;
  signal n65_o : std_logic;
  signal f_n : std_logic;
  signal f_z : std_logic;
  signal f_c : std_logic;
  signal f_v : std_logic;
  constant n67_o : std_logic := '0';
  signal n68_o : std_logic;
  signal n69_o : std_logic;
  signal cc_res : std_logic;
  signal n77_o : std_logic;
  signal n79_o : std_logic;
  signal n80_o : std_logic;
  signal n81_o : std_logic_vector (3 downto 0);
  signal dm_data_out : std_logic_vector (31 downto 0);
begin
  wrap_clock <= clock;
  wrap_reset <= reset;
  -- src/processor.vhdl:12:15
  branch_offset <= n1_o; -- (signal)
  -- src/processor.vhdl:13:15
  branch <= n6_o; -- (signal)
  -- src/processor.vhdl:14:15
  pc_addr <= pc_read; -- (signal)
  -- src/processor.vhdl:16:15
  instruction <= im_data_out; -- (signal)
  -- src/processor.vhdl:18:15
  instr_class <= id_instr_class; -- (signal)
  -- src/processor.vhdl:19:15
  operation <= id_operation; -- (signal)
  -- src/processor.vhdl:20:15
  dp_subclass <= id_dp_subclass; -- (signal)
  -- src/processor.vhdl:21:15
  dp_operand_src <= id_dp_operand_src; -- (signal)
  -- src/processor.vhdl:22:15
  load_store <= id_load_store; -- (signal)
  -- src/processor.vhdl:23:15
  dt_offset_sign <= id_dt_offset_sign; -- (signal)
  -- src/processor.vhdl:24:15
  cond_field <= id_cond; -- (signal)
  -- src/processor.vhdl:26:15
  reg_addr2 <= n22_o; -- (signal)
  -- src/processor.vhdl:27:15
  reg_in <= n27_o; -- (signal)
  -- src/processor.vhdl:27:23
  reg_out1 <= rf_data_out1; -- (signal)
  -- src/processor.vhdl:27:33
  reg_out2 <= rf_data_out2; -- (signal)
  -- src/processor.vhdl:28:15
  reg_en <= n43_o; -- (signal)
  -- src/processor.vhdl:30:15
  operand1 <= reg_out1; -- (signal)
  -- src/processor.vhdl:30:25
  operand2 <= n52_o; -- (signal)
  -- src/processor.vhdl:30:35
  alu_out <= alu_result; -- (signal)
  -- src/processor.vhdl:31:15
  alu_carry <= alu_carry_out; -- (signal)
  -- src/processor.vhdl:33:15
  n_flag <= f_n; -- (signal)
  -- src/processor.vhdl:33:23
  z_flag <= f_z; -- (signal)
  -- src/processor.vhdl:33:31
  c_flag <= f_c; -- (signal)
  -- src/processor.vhdl:33:39
  v_flag <= f_v; -- (signal)
  -- src/processor.vhdl:34:15
  f_en <= n65_o; -- (signal)
  -- src/processor.vhdl:36:15
  cond_true <= cc_res; -- (signal)
  -- src/processor.vhdl:38:15
  dm_en <= n81_o; -- (signal)
  -- src/processor.vhdl:39:15
  dm_out <= dm_data_out; -- (signal)
  -- src/processor.vhdl:41:15
  rd <= n18_o; -- (signal)
  -- src/processor.vhdl:41:19
  rn <= n19_o; -- (signal)
  -- src/processor.vhdl:41:23
  rm <= n17_o; -- (signal)
  -- src/processor.vhdl:43:15
  alu_op <= n55_o; -- (signal)
  -- src/processor.vhdl:45:15
  s_bit <= id_s_bit; -- (signal)
  -- src/processor.vhdl:47:8
  pc : entity work.program_counter port map (
    reset => wrap_reset,
    clock => wrap_clock,
    branch => branch,
    offset => branch_offset,
    read => pc_read);
  -- src/processor.vhdl:56:36
  n1_o <= instruction (23 downto 0);
  -- src/processor.vhdl:57:39
  n4_o <= '1' when instr_class = "011" else '0';
  -- src/processor.vhdl:57:45
  n5_o <= n4_o and cond_true;
  -- src/processor.vhdl:57:22
  n6_o <= '0' when n5_o = '0' else '1';
  -- src/processor.vhdl:59:8
  im : entity work.program_memory port map (
    addr => pc_addr,
    data_out => im_data_out);
  -- src/processor.vhdl:64:8
  id : entity work.decoder port map (
    instruction => instruction,
    instr_class => id_instr_class,
    operation => id_operation,
    dp_subclass => id_dp_subclass,
    dp_operand_src => id_dp_operand_src,
    load_store => id_load_store,
    dt_offset_sign => id_dt_offset_sign,
    cond => id_cond,
    s_bit => id_s_bit);
  -- src/processor.vhdl:76:25
  n17_o <= instruction (3 downto 0);
  -- src/processor.vhdl:77:25
  n18_o <= instruction (15 downto 12);
  -- src/processor.vhdl:78:25
  n19_o <= instruction (19 downto 16);
  -- src/processor.vhdl:79:41
  n21_o <= '1' when instr_class = "001" else '0';
  -- src/processor.vhdl:79:24
  n22_o <= rm when n21_o = '0' else rd;
  -- src/processor.vhdl:81:8
  rf : entity work.reg_file port map (
    read_addr1 => rn,
    read_addr2 => reg_addr2,
    write_addr => rd,
    data_in => reg_in,
    write_enable => reg_en,
    clock => wrap_clock,
    data_out1 => rf_data_out1,
    data_out2 => rf_data_out2);
  -- src/processor.vhdl:91:42
  n26_o <= '1' when instr_class = "001" else '0';
  -- src/processor.vhdl:91:25
  n27_o <= alu_out when n26_o = '0' else dm_out;
  -- src/processor.vhdl:92:40
  n30_o <= '1' when instr_class = "001" else '0';
  -- src/processor.vhdl:92:60
  n32_o <= '1' when load_store = '0' else '0';
  -- src/processor.vhdl:92:45
  n33_o <= n30_o and n32_o;
  -- src/processor.vhdl:93:31
  n35_o <= '1' when instr_class = "000" else '0';
  -- src/processor.vhdl:93:53
  n37_o <= '1' when dp_subclass = "000" else '0';
  -- src/processor.vhdl:93:76
  n39_o <= '1' when dp_subclass = "001" else '0';
  -- src/processor.vhdl:93:61
  n40_o <= n37_o or n39_o;
  -- src/processor.vhdl:93:36
  n41_o <= n35_o and n40_o;
  -- src/processor.vhdl:92:68
  n42_o <= n33_o or n41_o;
  -- src/processor.vhdl:92:22
  n43_o <= '0' when n42_o = '0' else '1';
  -- src/processor.vhdl:97:64
  n45_o <= instruction (11 downto 0);
  -- src/processor.vhdl:97:37
  n46_o <= "00000000000000000000" & n45_o;  --  uext
  -- src/processor.vhdl:98:40
  n48_o <= '1' when dp_operand_src = '1' else '0';
  -- src/processor.vhdl:98:61
  n50_o <= '1' when instr_class = "001" else '0';
  -- src/processor.vhdl:98:46
  n51_o <= n48_o or n50_o;
  -- src/processor.vhdl:98:20
  n52_o <= reg_out2 when n51_o = '0' else n46_o;
  -- src/processor.vhdl:100:45
  n54_o <= '1' when instr_class = "000" else '0';
  -- src/processor.vhdl:100:28
  n55_o <= n59_o when n54_o = '0' else operation;
  -- src/processor.vhdl:101:42
  n58_o <= '1' when dt_offset_sign = '0' else '0';
  -- src/processor.vhdl:100:50
  n59_o <= "0010" when n58_o = '0' else "0100";
  -- src/processor.vhdl:103:8
  alu : entity work.alu port map (
    op1 => operand1,
    op2 => operand2,
    instr => alu_op,
    carry_in => c_flag,
    result => alu_result,
    carry_out => alu_carry_out);
  -- src/processor.vhdl:112:39
  n64_o <= '1' when instr_class = "000" else '0';
  -- src/processor.vhdl:112:22
  n65_o <= '0' when n64_o = '0' else s_bit;
  -- src/processor.vhdl:113:8
  f : entity work.flag_circuit port map (
    clock => wrap_clock,
    enable => f_en,
    alu_carry => alu_carry,
    shifter_carry => n67_o,
    dp_subclass => dp_subclass,
    operation => alu_op,
    s_bit => s_bit,
    op1 => n68_o,
    op2 => n69_o,
    result => alu_out,
    n => f_n,
    z => f_z,
    c => f_c,
    v => f_v);
  -- src/processor.vhdl:116:68
  n68_o <= operand1 (31);
  -- src/processor.vhdl:117:68
  n69_o <= operand2 (31);
  -- src/processor.vhdl:130:8
  cc : entity work.cond_checker port map (
    n => n_flag,
    z => z_flag,
    c => c_flag,
    v => v_flag,
    cond => cond_field,
    res => cc_res);
  -- src/processor.vhdl:139:41
  n77_o <= '1' when instr_class = "001" else '0';
  -- src/processor.vhdl:139:61
  n79_o <= '1' when load_store = '1' else '0';
  -- src/processor.vhdl:139:46
  n80_o <= n77_o and n79_o;
  -- src/processor.vhdl:139:24
  n81_o <= "0000" when n80_o = '0' else "1111";
  -- src/processor.vhdl:140:8
  dm : entity work.data_memory port map (
    addr => alu_out,
    write_enable => dm_en,
    clock => wrap_clock,
    data_in => reg_out2,
    data_out => dm_data_out);
end rtl;
