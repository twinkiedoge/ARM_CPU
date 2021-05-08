library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end;

architecture sim of testbench is 
	component alu
		
		port(
        srcA: in std_logic_vector(31 downto 0);
        srcB: in std_logic_vector(31 downto 0);
        command: in std_logic_vector(3 downto 0);
        result: out std_logic_vector(31 downto 0);
        flags: out std_logic_vector(3 downto 0) -- NZCV
    );
	
	end component;
	
	signal srcA: std_logic_vector(31 downto 0);
	signal srcb: std_logic_vector(31 downto 0);
	signal command: std_logic_vector(3 downto 0); 
	signal result: std_logic_vector(31 downto 0);
	signal flags: std_logic_vector(3 downto 0);
	
	begin
	
	dut: alu port map(srcA => srcA, srcB => srcB, command => command, result => result, flags => flags);
	
	process begin
	--AND
	srcA <= "00000000000000000000000000000001";
	srcB <= "00000000000000000000000000000000";
	command <= "0000";

	-- AND.T1 (passed)
    wait for 10 ns;
	assert result = "00000000000000000000000000000000" report "bitwise AND failed test 1 (result)";
    assert flags = "0100" report "bitwise AND failed test 1 (flags)";
    
    
    -- AND.T2 (passed)
    srcA <= "00000000000000000000000000000001";
	srcB <= "00000000000000000000000000000001";
    wait for 10 ns;
	assert result = "00000000000000000000000000000001" report "bitwise AND failed test 2 (result)";
    assert flags = "0000" report "bitwise AND failed test 2 (flags)";
    
    
    
    
    --SUB------------------------------------------------------------------------------------------------------
    srcA <= "00000000000000000000000000000001";
	srcB <= "00000000000000000000000000000000";
	command <= "0010";
    
    --SUB.T1 1-0 (passed)
    wait for 10 ns;
    assert result = "00000000000000000000000000000001" report "SUB failed test 1 result: " & to_string(result);
    assert flags = "0000" report "SUB failed test 1 (flags)";
    
    --SUB.T2 0-(-1) (passed)
    srcA <= "00000000000000000000000000000000";
	srcB <= "11111111111111111111111111111111";
    wait for 10 ns;
    assert result = "00000000000000000000000000000001" report "SUB failed test 2. result: " & to_string(result);
    assert flags = "0000" report "SUB failed test 2. flags: " & to_string(flags);
    
    --SUB.T3 1-1 (passed)
  	srcA <= "00000000000000000000000000000001";
	srcB <= "00000000000000000000000000000001";
    wait for 10 ns;
    assert result = "00000000000000000000000000000000" report "SUB failed test 3. result: " & to_string(result);
    assert flags = "0100" report "SUB failed test 3. flags: " & to_string(flags);
    
    --SUB.T4 0-1 (passed)
  	srcA <= "00000000000000000000000000000000";
	srcB <= "00000000000000000000000000000001";
    wait for 10 ns;
    assert result = "11111111111111111111111111111111" report "SUB failed test 4. result: " & to_string(result);
    assert flags = "1000" report "SUB failed test 4. flags: " & to_string(flags);
    
    --SUB.T5 (positive - negative -  overflow and carry) (passed)
    srcA <= "01000000000000000000000000000000";
	srcB <= "10000000000000000000000000000000";
    wait for 10 ns;
    assert result = "11000000000000000000000000000000" report "SUB failed test 5. result: " & to_string(result); 
    assert flags = "1011" report "SUB failed test 5. flags: " & to_string(flags);
    
    --SUB.T6 (passed)
    srcA <= "00100000000000000000000000000000";
	srcB <= "10000000000000000000000000000000";
    wait for 10 ns;
    assert result = "10100000000000000000000000000000" report "SUB failed test 6. result: " & to_string(result); 
    assert flags = "1011" report "SUB failed test 6. flags: " & to_string(flags);
    
    --SUB.T7 (passed)
    srcA <= "10000000000000000000000000000000";
	srcB <= "00100000000000000000000000000000";
    wait for 10 ns;
    assert result = "01100000000000000000000000000000" report "SUB failed test 7. result: " & to_string(result); 
    assert flags = "0011" report "SUB failed test 7. flags: " & to_string(flags);
    
    
    
    
    --RSB------------------------------------------------------------------------------------------------------
    srcB <= "00000000000000000000000000000001";
	srcA <= "00000000000000000000000000000000";
	command <= "0011";
    
    --RSB.T1 1-0 (passed)
    wait for 10 ns;
    assert result = "00000000000000000000000000000001" report "RSB failed test 1 result: " & to_string(result);
    assert flags = "0000" report "SUB failed test 1 (flags)";
    
    --RSB.T2 0-(-1) (passed)
    srcB <= "00000000000000000000000000000000";
	srcA <= "11111111111111111111111111111111";
    wait for 10 ns;
    assert result = "00000000000000000000000000000001" report "RSB failed test 2. result: " & to_string(result);
    assert flags = "0000" report "SUB failed test 2. flags: " & to_string(flags);
    
    --RSB.T3 1-1 (passed)
  	srcB <= "00000000000000000000000000000001";
	srcA <= "00000000000000000000000000000001";
    wait for 10 ns;
    assert result = "00000000000000000000000000000000" report "RSB failed test 3. result: " & to_string(result);
    assert flags = "0100" report "SUB failed test 3. flags: " & to_string(flags);
    
    --RSB.T4 0-1 (passed)
  	srcB <= "00000000000000000000000000000000";
	srcA <= "00000000000000000000000000000001";
    wait for 10 ns;
    assert result = "11111111111111111111111111111111" report "RSB failed test 4. result: " & to_string(result);
    assert flags = "1000" report "SUB failed test 4. flags: " & to_string(flags);
    
    --RSB.T5 (passed)
    srcB <= "01000000000000000000000000000000";
	srcA <= "10000000000000000000000000000000";
    wait for 10 ns;
    assert result = "11000000000000000000000000000000" report "RSB failed test 5. result: " & to_string(result); 
    assert flags = "1011" report "SUB failed test 5. flags: " & to_string(flags);
    
    --RSB.T6 (passed)
    srcB <= "00100000000000000000000000000000";
	srcA <= "10000000000000000000000000000000";
    wait for 10 ns;
    assert result = "10100000000000000000000000000000" report "RSB failed test 6. result: " & to_string(result); 
    assert flags = "1011" report "SUB failed test 6. flags: " & to_string(flags);
    
    --RSB.T7 (passed)
    srcB <= "10000000000000000000000000000000";
	srcA <= "00100000000000000000000000000000";
    wait for 10 ns;
    assert result = "01100000000000000000000000000000" report "RSB failed test 7. result: " & to_string(result); 
    assert flags = "0011" report "SUB failed test 7. flags: " & to_string(flags);
    
    
    
    --ADD------------------------------------------------------------------------------------------------------
   	srcB <= "00000000000000000000000000000001";
	srcA <= "00000000000000000000000000000000";
	command <= "0011";
    
    
    wait;
	
	end process;
end;
