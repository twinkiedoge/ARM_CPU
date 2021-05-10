library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;


entity aluDecoderTest is 
end aluDecoderTest;

architecture synth of aluDecoderTest is
component ALUDecoder is
port(
	func : in std_logic_vector(5 downto 0);
    ALUOp : in std_logic;
    ALUControl : out std_logic_vector(1 downto 0);
    FlagW : out std_logic_vector(1 downto 0)
);
end component;

signal aOp : std_logic;
signal func2 : std_logic_vector(5 downto 0);
signal ALUControl : std_logic_vector(1 downto 0);
signal FlagW : std_logic_vector(1 downto 0);

begin
    	aluD : ALUDecoder port map(func => func2, ALUOp => aOp, ALUControl => ALUControl, FlagW => FlagW); 
	
	process is
	begin
		--testing ALUDecoder
		func2 <= "111111";
		aOp <= '0';
		wait for 10 ns;
		if (ALUControl = "00" and FlagW = "00") then 
			report "success alu";
		else 
			report "failed";
			report "ALUControl: " & to_string(ALUControl);
			report "flagW: " & to_string(FlagW);
		end if;
		
		
		aOp <= '1';
		func2 <= "001000";
		wait for 10 ns;
		if (ALUControl = "00" and FlagW = "00") then 
			report "success alu";
		else 
			report "failed";
			report "ALUControl: " & to_string(ALUControl);
			report "flagW: " & to_string(FlagW);
		end if;
		
		func2 <= "000101";
		wait for 10 ns;
		if (ALUControl = "01" and FlagW = "11") then 
			report "success alu";
		else 
			report "failed";
			report "ALUControl: " & to_string(ALUControl);
			report "flagW: " & to_string(FlagW);
		end if;
		
		func2 <= "000100";
		wait for 10 ns;
		if (ALUControl = "01" and FlagW = "00") then 
			report "success alu";
		else 
			report "failed";
			report "ALUControl: " & to_string(ALUControl);
			report "flagW: " & to_string(FlagW);
		end if;
		
		func2 <= "000000";
		wait for 10 ns;
		if (ALUControl = "10" and FlagW = "00") then 
			report "success alu";
		else 
			report "failed";
			report "ALUControl: " & to_string(ALUControl);
			report "flagW: " & to_string(FlagW);
		end if;
		
		func2 <= "000001";
		wait for 10 ns;
		if (ALUControl = "10" and FlagW = "10") then 
			report "success alu";
		else 
			report "failed";
			report "ALUControl: " & to_string(ALUControl);
			report "flagW: " & to_string(FlagW);
		end if;
		
		func2 <= "011000";
		wait for 10 ns;
		if (ALUControl = "11" and FlagW = "00") then 
			report "success alu";
		else 
			report "failed";
			report "ALUControl: " & to_string(ALUControl);
			report "flagW: " & to_string(FlagW);
		end if;
		
		
		func2 <= "011001";
		wait for 10 ns;
		if (ALUControl = "11" and FlagW = "10") then 
			report "success alu";
		else 
			report "failed";
			report "ALUControl: " & to_string(ALUControl);
			report "flagW: " & to_string(FlagW);
		end if;
		wait;
	end process;
end synth;
