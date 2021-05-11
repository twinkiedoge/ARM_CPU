library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;


entity controlTest is 
end controlTest;

architecture synth of controlTest is

component mainDecoder is
port(
	func : in std_logic_vector(5 downto 0);
    op : in std_logic_vector(1 downto 0);
    Rd : in std_logic_vector(3 downto 0);
    memtoReg : out std_logic;
    memW : out std_logic;
    regW : out std_logic;
    ALUSrc : out std_logic;
    immSrc : out std_logic_vector(1 downto 0);
    ALUOp : out std_logic;
    regSrc : out std_logic_vector(1 downto 0);
    PCS : out std_logic
);
end component;

signal func : std_logic_vector(5 downto 0);
signal op : std_logic_vector(1 downto 0);
signal memtoReg : std_logic;
signal memW : std_logic;
signal regW : std_logic;
signal ALUSrc : std_logic;
signal immSrc : std_logic_vector(1 downto 0);
signal PCS : std_logic;
signal Rd : std_logic_vector(3 downto 0);
signal ALUOp : std_logic;
signal regSrc : std_logic_vector(1 downto 0);

begin
    	mD : mainDecoder port map(func => func, op => op, Rd => Rd, memtoReg => memtoReg, memW => memW, regW => regW, ALUSrc => ALUSrc, immSrc => immSrc, ALUOp => ALUOp, regSrc => regSrc, PCS => PCS);

	process is
	begin
		--testing mainDecoder 
		func <= "011110";
		op <= "00";
		wait for 10 ns;
		assert(memtoReg = '0' and memW = '0' and ALUSrc = '0' and regW = '1' and immSrc = "00" and ALUOp <= '1' and regSrc = "00") report "failed" severity error;
		
		func <= "111110";
		op <= "00";
		wait for 10 ns;
		assert(memtoReg = '0' and memW = '0' and ALUSrc = '1' and immSrc = "00" and regW = '1' and ALUOp <= '1' and regSrc(0) = '0') report "failed" severity error;
		
		
		
		op <= "01";
		wait for 10 ns;
		assert(memW = '1' and ALUSrc = '1' and immSrc = "01" and regW = '0' and ALUOp <= '0' and regSrc = "10") report "failed" severity error;
		
		
		func <= "111111";
		op <= "01";
		wait for 10 ns;
		assert(memtoReg = '1' and memW = '0' and ALUSrc = '1' and immSrc = "01" and regW = '1' and ALUOp <= '0' and regSrc(0) = '0') report "failed" severity error;
		
		
		op <= "10";
		wait for 10 ns;
		assert(memtoReg = '0' and memW = '0' and ALUSrc = '1' and immSrc = "10" and regW = '0' and ALUOp <= '0' and regSrc(0) = '1') report "failed" severity error;	
		
		
		--testing pc updates
		Rd <= "1010";
		wait for 10 ns;
		assert(PCS = '0') report "failed" severity error;	
		
		Rd <= "1011";
		wait for 10 ns;
		assert(PCS = '0') report "failed" severity error;
		
		Rd <= "1110";
		wait for 10 ns;
		assert(PCS = '1') report "failed" severity error;
		
		
		Rd <= "0000";
		wait for 10 ns;
		assert(PCS = '0') report "failed" severity error;
		wait;
	end process;
end synth;
