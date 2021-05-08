library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity PCtest is
end PCtest;

architecture synth of PCtest is
component programcounter is
  port(
    clk : in std_logic;
    reset : in std_logic;
    branch : in std_logic;
    branchAddr : in std_logic_vector(31 downto 0);
    pc : out unsigned(31 downto 0)
  );
end component;

signal reset : std_logic := '1';
signal branch : std_logic := '0';
signal branchAddr: std_logic_vector(31 downto 0);
signal pcSig : unsigned (31 downto 0);
signal clk : std_logic;


begin
  pCounter : programcounter port map (clk => clk, reset => reset, branch => branch, branchAddr => branchAddr, pc => pcSig);
  
  
  --clock with 20 period
  process begin
  	clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns; 
  end process;
  
  
  
  process is
  begin
  
  --testing reset (reset is initialized to 1)
    wait for 10 ns;
  	if (pcSig = "00000000000000000000000000000000") then
    	report "success";
    else
    	report "failed";
    end if;
  	wait for 10 ns;
    
   --checking if the counter is incrementing by 4 (waiting 2 clock cycles)
    reset <= '0'; 
    wait for 40 ns;
    if (pcSig = 8) then
    	report "success when counting";
    else
    	report "failed";
    end if;
    
    wait for 10 ns;
    
    --checking if the counter is set to the value of branchAddr
    branch <= '1';
    branchAddr <= "00000000000000000000000001111111";
    wait for 50 ns;  
    if(pcSig = "00000000000000000000000001111111") then
    	report "success with branchaddr change";
    else
    	report "failed";
    end if;
    
    --checking if the counter begins to increment after branch is set low
    --also confirming that the counter is not set to branchAddr when branch is low
    wait for 5 ns;
    branch <= '0';
    wait for 5 ns; 
    branchAddr <= "00111000000000000000000001111111";
    
    wait for 40 ns; --
    if (pcSig = 135) then
    	report "success when counting after branch and branchaddr";
    else
    	report "failed";
    end if;  
    
    --testing if counter is set to branchAddr (set before branch is high) when branch is set high
    --		then testing if branch is high for long enough for the branchAddr to change and 
    -- 	then to have a rising clock edge if the pc counter is then set to the new
    --		value
    wait for 10 ns;
    branch <= '1';
    wait for 15 ns;
    branchAddr <= "00000000000000000000101011111111";
    wait for 25 ns;
    branch <= '0';
    wait for 40 ns;
    
    
    if (pcSig = 2823) then
    	report "success when counting branch=0 with branchaddr change";
    else
    	report "failed";
    end if; 
    
    -- checking reset value after pc has been set to the branchAddr values/counted
    wait for 7 ns; 
    reset <= '1';
    wait for 15 ns;
    
    
    if (pcSig = 0) then
    	report "success final reset";
    else
    	report "failed";
    end if; 
    
    
    wait;
  end process;
end synth;