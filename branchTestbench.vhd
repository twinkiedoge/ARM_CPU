library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;


entity branchTest is 
end branchTest;

architecture synth of branchTest is
--put in branch component (maybe a preset of PC to 0)
--input instruction 
--output of PC
signal instruction : std_logic_vector(31 downto 0);
signal PC : std_logic_vector(31 downto 0);
begin
--instantiate branch component
	process is
	begin
		--assuming PC starts at 0
		--testing if pc changes when B = 0
		instruction(31 downto 28) <= "1010"; -- cond
		instruction(27 downto 26) <= "10"; -- op
		instruction(25) <= '0'; -- funct (branch ignoring L)
		instruction(23 downto 0) <= "000000000000000000000001";  -- imm24 
		wait for 10 ns;
		assert(PC = "000000000000000000000000000000000") report "failed" severity error;
		
		
		--testing if pc changes when B = 1
		instruction(25) <= '1'; -- funct (branch ignoring L)
		instruction(23 downto 0) <= "000000000000000000000001";  -- imm24 
		wait for 10 ns;
		assert(PC = "000000000000000000000000000001100") report "failed" severity error;
		
		
		instruction(27 downto 26) <= "10"; -- op
		instruction(25) <= '1'; -- funct (branch ignoring L)
		instruction(23 downto 0) <= "000000000000000000011111";  -- imm24 
		wait for 10 ns;
		assert(PC = "000000000000000000000000010010000") report "failed" severity error;
		
		
		
		--testing negative imm24
		instruction(27 downto 26) <= "10"; -- op
		instruction(25) <= '1'; -- funct (branch ignoring L)
		instruction(23 downto 0) <= "111111111111111111111010";  -- imm24 
		wait for 10 ns;
		assert(PC = "000000000000000000000000001101000") report "failed" severity error;
	wait;
	end process;
end synth;
