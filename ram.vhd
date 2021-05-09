library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity ram is 
	port(
		clk : in std_logic;
		write_enable : in std_logic;
		addr : in unsigned(31 downto 0);
		write_data : in unsigned(31 downto 0);
		read_data : out unsigned(31 downto 0)
	);
end; 



architecture synth of ram is
  
	type mem_array is array(0 to 31) of unsigned(31 downto 0);
	signal mem : mem_array;

begin
	process (clk)
	begin
		if (clk'event and clk = '1') then
			if (write_enable = '1') then
				mem(to_integer(addr)) <= write_data; --synchronous write
			end if;
		end if;
	end process;

	read_data <= mem(to_integer(addr)); --asynchronous read
        
end; 
