--  testbench for immediate extension module
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

entity immex_test is
-- no ports, since this is a testbench
end immex_test;

architecture test of immex_test is

component immextend is
  port(
	imm : in std_logic_vector(11 downto 0);
	immout : out std_logic_vector(31 downto 0)
  );
end component;

signal imm : std_logic_vector(11 downto 0);
signal immout : std_logic_vector(31 downto 0);

begin

    dut: immextend port map(imm, immout);
    
    process begin
		imm <= "000011100100"; wait for 10 ns;
			assert immout = (24b"0" & "11100100")
			report "test failed";
		
		imm <= "101111111111"; wait for 10 ns;
			assert immout = (14b"0" & "11111111" & 10b"0")
			report "test failed";
		
		imm <= "101111111111"; wait for 10 ns;
			assert immout = (14b"0" & "11111111" & 10b"0")
			report "test failed";
		
		imm <= "111110010101"; wait for 10 ns;
			assert immout = (22b"0" & "10010101" & "00")
			report "test failed";
	wait;
    end process;

end test;

