library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity add8 is
    port (
      x : in unsigned(31 downto 0);
      xplus8 : out unsigned(31 downto 0)
    );
end;
 
architecture synth of add8 is 
begin
   xplus8 <= x + 8;
end; 
