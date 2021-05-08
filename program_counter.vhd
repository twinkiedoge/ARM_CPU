library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity programcounter is
  port(
    clk : in std_logic;
    reset : in std_logic;
    branch : in std_logic;
    branchAddr : in std_logic_vector(31 downto 0);
    pc : inout unsigned(31 downto 0)
  );
end;



architecture synth of programcounter is
begin
  process(clk)
  begin
      if (reset = '1') then
      	pc <= "00000000000000000000000000000000";
      elsif(rising_edge(clk)) then
        if (branch = '1') then
        	pc <= unsigned(branchAddr);
        elsif (branch = '0') then
          pc <=  pc + 4;
        end if;
      end if;
  end process;
end;