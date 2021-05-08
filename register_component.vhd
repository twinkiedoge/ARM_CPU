library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg is
  port(
    addressIn : in unsigned (3 downto 0);
    dataIn : in std_logic_vector(31 downto 0);
    addressOut : out unsigned (3 downto 0);
    dataOut : out std_logic_vector(31 downto 0)
  );
end reg;


architecture synth of reg is 
begin
	addressOut <= addressIn;
	dataOut <= dataIn;	
end;