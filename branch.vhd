library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity branch is
port(
	PC8 : in std_logic_vector(31 downto 0);
	instruction : in std_logic_vector(31 downto 0);
	PC : out std_logic_vector(31 downto 0)
);
end branch;


architecture synth of branch is
--signal imm24 : std_logic_vector(23 downto 0);
signal imm24_4 : std_logic_vector(25 downto 0);
begin
	
	imm24_4 <= instruction(23 downto 0) & "00";
	PC <= std_logic_vector(unsigned(PC8) + unsigned(imm24_4));
end synth;
