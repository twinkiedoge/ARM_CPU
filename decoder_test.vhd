--  testbench for decoder
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use IEEE.numeric_std.all;

entity decoder_test is
-- no ports, since this is a testbench
end decoder_test;

architecture test of decoder_test is

component decoder is
  port(
	instruction : in std_logic_vector(31 downto 0);
	aluControl : out std_logic_vector(3 downto 0);
	addrA : out unsigned(3 downto 0);
	addrB : out unsigned(3 downto 0);
	addrC : out unsigned(3 downto 0);
	useImm : out std_logic
	);
end component;

signal instruct : std_logic_vector(31 downto 0);
signal alu : std_logic_vector(3 downto 0);
signal addr1 : unsigned(3 downto 0);
signal addr2 : unsigned(3 downto 0);
signal addr3 : unsigned(3 downto 0);
signal imm : std_logic;

begin

    dut: decoder port map(instruct, alu, addr1, addr2, addr3, imm);
    
    process begin
		instruct <= "11001011001110101001111101010010"; wait for 10 ns;
			assert alu = "1001" report "alu test failed";
           
            assert imm = '1' report "imm test failed";
            
			assert addr1 = "1010" report "addr A test failed";
            
			assert addr3 = "1001" report "addr C test failed";
            
			assert addr2 = "0010" report "addr B test failed";
            wait for 10 ns;
	wait;
    end process;

end test;

