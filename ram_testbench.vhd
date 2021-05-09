library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity ram_tb is
end entity;



architecture tb of ram_tb is

component ram is 
	port(
		clk : in std_logic;
		write_enable : in std_logic;
		addr : in unsigned(31 downto 0);
		write_data : in unsigned(31 downto 0);
		read_data : out unsigned(31 downto 0)
	);
end component;


signal clk : std_logic;
signal write_enable : std_logic;
signal addr : unsigned(31 downto 0);
signal write_data : unsigned(31 downto 0);
signal read_data : unsigned(31 downto 0);


begin

dut : ram port map(
	clk => clk,
	write_enable => write_enable,
	addr => addr,
	write_data => write_data,
	read_data => read_data
	);

	
clk_process : process
	begin
    
		clk <= '0';
    wait for 10 ns;
  
		clk <= '1';
  	wait for 10 ns;
      
	end process; 



stimulate_process : process

	begin

	wait until rising_edge(clk);
	addr <= "00000000000000000000000000000000";
	write_data <= "00000000000000000000000000000000";
	write_enable <= '0';

	wait until rising_edge(clk);
	write_enable <= '1';
	write_data <= "00000000000000000000000000000001";

	wait;

end process; 

end architecture;

