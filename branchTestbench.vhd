library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;


entity branchTest is 
end branchTest;

architecture synth of branchTest is
component branch is
port(
	PC8 : in std_logic_vector(31 downto 0);
	instruction : in std_logic_vector(31 downto 0);
	PC : out std_logic_vector(31 downto 0)
);
end component;
signal PC8 : std_logic_vector(31 downto 0);
signal instruction : std_logic_vector(31 downto 0);
signal PC : std_logic_vector(31 downto 0);
begin
b : branch port map(PC8 => PC8, instruction => instruction, PC => PC);
	process is
	begin
		-- imm24 = 1
		instruction(31 downto 28) <= "1010"; -- cond
		instruction(27 downto 26) <= "10"; -- op
		instruction(23 downto 0) <= "000000000000000000000001"; 
		PC8 <= "00000000000000000000000000000000";
		wait for 10 ns;
		assert(PC = "00000000000000000000000000000100") report to_string(PC) severity error;
		
		--imm24 = 1025
		instruction(23 downto 0) <= "000000000000010000000001"; 
		wait for 10 ns;
		assert(PC = "00000000000000000001000000000100") report "failed" severity error;
		
		
		--imm24 = 31
		PC8 <= "00000000000000000000001110000000";
		instruction(23 downto 0) <= "000000000000000000011111"; 
		wait for 10 ns;
		assert(PC = "00000000000000000000001111111100") report "failed" severity error;
		
		--imm24 = -6
		instruction(23 downto 0) <= "111111111111111111111010";  
		wait for 10 ns;
		assert(PC = "00000100000000000000001101101000") report "failed" severity error;
	wait;
	end process;
end synth;
