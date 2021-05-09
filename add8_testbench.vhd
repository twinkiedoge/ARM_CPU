library IEEE;
use IEEE.std_logic_1164.all;
use IEE.numeric_std.all;

entity add8_tb is
end entity;

architecture tb of add8_tb is 
  
component add8 is
    port (
      x : in unsigned(31 downto 0);
      xplus8 : out unsigned(31 downto 0)
    );
end component;

signal x : unsigned(31 downto 0);
signal xplus8 : unsigned(31 downto 0);


begin

-- checking if add8 is incrementing x by 8

x <= "00000000000000000000000000000000";
assert (xplus8 = "00000000000000000000000000001000") report "failed" severity error;

x <= "11111111111111111111111111111111";
assert (xplus8 = "00000000000000000000000000000111") report "failed" severity error;

end; 
