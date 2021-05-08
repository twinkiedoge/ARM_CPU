library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;


entity registerTest is 
end registerTest;

architecture synth of registertest is
component regfile is
port(
clk : in std_logic;
A1 : in unsigned(3 downto 0); -- Address for port 1 (read 1)
A2 : in unsigned(3 downto 0); -- Address for port 2 (read 2)
A3 : in unsigned(3 downto 0); -- Address for port 3 (write 3)
WE3 : in std_logic; -- Write enable for port 3
R15 : in std_logic_vector(31 downto 0); -- Passthrough for PC+8
RD1 : out std_logic_vector(31 downto 0); -- Data result for port 1
RD2 : out std_logic_vector(31 downto 0); -- Data result for port 2
WD3 : in std_logic_vector(31 downto 0) -- Data input for port 3
);
end component;

signal A1, A2 : unsigned(3 downto 0);
signal A3 : unsigned(3 downto 0) := "0000";
signal WE3 : std_logic := '1'; 
signal clk : std_logic;
signal WD3 : std_logic_vector(31 downto 0) := "00000000000000000000000000000001";
signal RD1, R15, RD2 : std_logic_vector(31 downto 0);


begin
	reg : regfile port map(A1 => A1, A2 => A2, A3 => A3, WE3 => WE3, R15 => R15, RD1 => RD1, RD2 => RD2, WD3 => WD3, clk => clk);
	
    --clock with 20 ns period
    process begin
      clk <= '0';
      wait for 10 ns;
      clk <= '1';
      wait for 10 ns; 
    end process;
    
    process is 
    begin
    	
    	A1 <= "1111";
    	A2 <= "1111";
    	-- testing write
    	wait for 30 ns;
        --write R1
    	A3 <= "0001";
    	WD3 <= "00000000000000000000000000000011";
        wait for 30 ns; 
        
        --write R2
        A3 <= "0010";
    	WD3 <= "00000000000000000000000000000111";
        wait for 30 ns; 
        
        --write R3
        A3 <= "0011";
    	WD3 <= "00000000000000000000000000001111";
        wait for 30 ns; 
        
        --write R4
        A3 <= "0100";
    	WD3 <= "00000000000000000000000000011111";
        wait for 30 ns; 
        
        --write R5
        A3 <= "0101";
    	WD3 <= "00000000000000000000000000111111";
        wait for 30 ns; 
        
        --write R6
        A3 <= "0110";
    	WD3 <= "00000000000000000000000001111111";
        wait for 30 ns; 
        
        --write R7
        A3 <= "0111";
    	WD3 <= "00000000000000000000000011111111";
        wait for 30 ns; 
        
        --write R8
        A3 <= "1000";
    	WD3 <= "00000000000000000000000111111111";
        wait for 30 ns; 
        
        --write R9
        A3 <= "1001";
    	WD3 <= "00000000000000000000001111111111";
        wait for 30 ns; 
        
        --write R10
        A3 <= "1010";
    	WD3 <= "00000000000000000000011111111111";
        wait for 30 ns; 
        
        --write R11
        A3 <= "1011";
    	WD3 <= "00000000000000000000111111111111";
        wait for 30 ns; 
        
        --write R12
        A3 <= "1100";
    	WD3 <= "00000000000000000001111111111111";
        wait for 30 ns; 
        
        --write R13
        A3 <= "1101";
    	WD3 <= "00000000000000000011111111111111";
        wait for 30 ns; 
        
        --write R14
        A3 <= "1110";
    	WD3 <= "00000000000000000111111111111111";
        wait for 30 ns;
        
        
        
        --testing read
        
        --read R0
        WE3 <= '0';
        A1 <= "0000";
	wait for 10 ns;
        if (RD1 = "00000000000000000000000000000001") then 
        	report "success";
        else 
        	report "RD1: " & to_string(RD1);
        	report "failed";
        end if;
        
        --read R1
        A1 <= "0001";
	wait for 10 ns;
        if (RD1 = "00000000000000000000000000000011") then 
        	report "success";
        else 
        	report "RD1: " & to_string(RD1);
        	report "failed";
        end if;
        
        
        --read R2
        A1 <= "0010";
	wait for 10 ns;
        if (RD1 = "00000000000000000000000000000111") then 
        	report "success";
        else 
        	report "RD1: " & to_string(RD1);
        	report "failed";
        end if;
        
        --read R3
        A2 <= "0011";
	wait for 10 ns;
        if (RD2 = "00000000000000000000000000001111") then 
        	report "success";
        else 
        	report "RD2: " & to_string(RD2);
        	report "failed";
        end if;
	
        --read R4
		A2 <= "0100";
		wait for 10 ns;
        if (RD2 = "00000000000000000000000000011111") then 
        	report "success";
        else 
        	report "RD2: " & to_string(RD2);
        	report "failed";
        end if;
	
		
        --read R5
		A2 <= "0101";
		wait for 10 ns;
        if (RD2 = "00000000000000000000000000111111") then 
        	report "success";
        else 
        	report "RD2: " & to_string(RD2);
        	report "failed";
        end if;
	
		
        --read R6
		A2 <= "0110";
		wait for 10 ns;
        if (RD2 = "00000000000000000000000001111111") then 
        	report "success";
        else 
        	report "RD2: " & to_string(RD2);
        	report "failed";
        end if;
	
		--checking if the write waits until the enable is high
		WD3 <= "00000111110000011111000001111100";
		A3 <= "0101";
		wait for 10 ns;
	
		A1 <= "0101";
		wait for 10 ns;
		if (RD1 = "00000000000000000000000000111111") then 
			report "success";
		else
			report "RD1: " & to_string(RD1);
        	report "failed";
        end if;
	
		--checking write is done after enable is high
		wait for 5 ns;
		WE3 <= '1';
		wait for 20 ns;
		WE3 <= '0';
		wait for 10 ns;
		A2 <= "0101";
		wait for 10 ns; 
		if (RD2 = "00000111110000011111000001111100") then 
			report "success";
		else
			report "RD2: " & to_string(RD2);
        	report "failed";
        end if;
        
        
        --checking the reading/writing of R15 
        R15 <= "11111111110000000000111111111100";
        WE3 <= '1';
        wait for 10 ns;
        
        WD3 <= R15;
        A3 <= "1111";
        wait for 20 ns;
		
        WE3 <= '0';
        A1 <= "1111";
        wait for 10 ns;
        
        if (RD1 = "11111111110000000000111111111100") then 
			report "success";
		else
        	report "failed";
        end if;          
    wait;
    end process;
end;