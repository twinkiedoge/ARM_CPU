library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity ALUDecoder is
port(
	func : in std_logic_vector(5 downto 0);
    ALUOp : in std_logic;
    ALUControl : out std_logic_vector(1 downto 0);
    FlagW : out std_logic_vector(1 downto 0)
);
end ALUDecoder;


architecture synth of ALUDecoder is
signal S : std_logic;
signal cmd : std_logic_vector(3 downto 0);
begin
	cmd <= func (4 downto 1);
	S <= func(0);
	ALUControl <= "00" when (ALUOp = '0' or (ALUOp = '1' and cmd = "0100")) else -- ADD
    		       "01" when (ALUOp = '1' and cmd = "0010") else --SUB
                      "10" when (ALUOp = '1' and cmd = "0000") else --AND
                      "11" when (ALUOp = '1' and cmd = "1100"); --OR
	FlagW <= "00" when (ALUOp = '0' or S = '0') else                      
    		 "11" when (S = '1' and (cmd = "0100" or cmd = "0010")) else  -- ADD and SUB
           	 "10" when (S = '1' and (cmd = "0000" or cmd = "1100")); -- AND and OR
--see table 7.3 
	--note: all flags are updated with add and sub, but only N and Z for AND and ORR
--FlagW(1) for updating N and Z (flags 3:2)
--FlagW(0) for updating C and V (flags 1:0)
end synth;
