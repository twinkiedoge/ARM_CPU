library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity mainDecoder is
port(
	func : in std_logic_vector(5 downto 0);
    op : in std_logic_vector(1 downto 0);
    Rd : in std_logic_vector(3 downto 0);
    B : out std_logic;
    memtoReg : out std_logic;
    memW : out std_logic;
    regW : out std_logic;
    ALUSrc : out std_logic;
    immSrc : out std_logic_vector(1 downto 0);
    ALUOp : out std_logic;
    regSrc : out std_logic_vector(1 downto 0);
    PCS : out std_logic
);
end mainDecoder;


architecture synth of mainDecoder is
signal func5 : std_logic;
signal func0 : std_logic;

begin
	func5 <= func(5);
	func0 <= func(0);
	
        --LDR update
        memtoReg <= '1' when (op = "01" and func0 = '1') else '0'; --1: from memory, 0: from ALUresult
        memW <= '1' when (op = "01" and func0 = '0') else '0';
        --STR update
        ALUSrc <= '0' when (op = "00" and func5 = '0') else '1'; -- 0: use Rd, 1: STR
        --register update
        regW <= '1' when (op = "00" or (op = "01" and func0 = '1')) else '0';
        --immediate extension update
        immSrc <= op;
        --pc datapath update
        PCS <= '1' when (Rd = "1110") else '0';
        --ALUOp update 
        ALUOp <= '1' when (op = "00") else '0'; 
        --regSrc
        regSrc <= "00" when (op = "00") else
                  "10" when (op = "01") else
                  "01" when (op = "10"); 
                  
        B <= '1' when (op = "10") else '0';
                  
end synth;
