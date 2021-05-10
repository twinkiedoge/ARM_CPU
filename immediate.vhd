library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity immextend is
	port(
		imm : in std_logic_vector(11 downto 0);
		immout : out std_logic_vector(31 downto 0)
	);
end;

architecture behave of immextend is

signal rot : std_logic_vector(3 downto 0);

begin

rot <= imm(11 downto 8);

process(all) begin

case rot is

	when "0000" => immout <= (24b"0" & imm(7 downto 0));
	when "0001" => immout <= (imm(1 downto 0) & 24b"0" & imm(7 downto 2));
	when "0010" => immout <= (imm(3 downto 0) & 24b"0" & imm(7 downto 4));	
	when "0011" => immout <= (imm(5 downto 0) & 24b"0" & imm(7 downto 6));
	when "0100" => immout <= (imm(7 downto 0) & 24b"0");
	when "0101" => immout <= (2b"0" & imm(7 downto 0) & 22b"0");
	when "0110" => immout <= (4b"0" & imm(7 downto 0) & 20b"0");	
	when "0111" => immout <= (6b"0" & imm(7 downto 0) & 18b"0");
	when "1000" => immout <= (8b"0" & imm(7 downto 0) & 16b"0");
	when "1001" => immout <= (10b"0" & imm(7 downto 0) & 14b"0");
	when "1010" => immout <= (12b"0" & imm(7 downto 0) & 12b"0");	
	when "1011" => immout <= (14b"0" & imm(7 downto 0) & 10b"0");
	when "1100" => immout <= (16b"0" & imm(7 downto 0) & 8b"0");
	when "1101" => immout <= (18b"0" & imm(7 downto 0) & 6b"0");
	when "1110" => immout <= (20b"0" & imm(7 downto 0) & 4b"0");	
	when "1111" => immout <= (22b"0" & imm(7 downto 0) & 2b"0");
	when others => immout <= 32b"Z";
end case;

end process;

end;
