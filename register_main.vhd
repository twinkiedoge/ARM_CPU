library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity regfile is
port(
clk : in std_logic;
A1 : in unsigned(3 downto 0); -- Address for port 1 (read 1)
A2 : in unsigned(3 downto 0); -- Address for port 2 (read 2)
A3 : in unsigned(3 downto 0); -- Address for port 3 (write 3)
WE3 : in std_logic;           -- Write enable for port 3
R15 : in std_logic_vector(31 downto 0); -- Passthrough for PC+8
RD1 : out std_logic_vector(31 downto 0); -- Data result for port 1
RD2 : out std_logic_vector(31 downto 0); -- Data result for port 2
WD3 : in std_logic_vector(31 downto 0) -- Data input for port 3
);
end;


architecture synth of regfile is
component sorter2 is 
	port (
	inputAddress : in unsigned (3 downto 0);
        inputData : in std_logic_vector(32 downto 0);
        Rport : out std_logic_vector(31 downto 0)
	);
end component;

signal inData : std_logic_vector(32 downto 0);

signal Rport : std_logic_vector(31 downto 0);
signal inputAddress : unsigned(3 downto 0);
signal write : std_logic := 'X';
signal rwSig : std_logic_vector(0 downto 0) := "1";
signal readDummyData : std_logic_vector(32 downto 0) := "000000000000000000000000000000000";

begin
s1 : sorter2 port map(inputAddress => inputAddress, inputData => inData, Rport => Rport);
    
    process (clk)
    begin
    	--write WD3 into the register with the address from AD3
       if (clk'event and clk = '1') then
		   if (WE3 = '1') then
				write <= '1';
			else
				write <= '0';
			end if;

		end if;
        
    end process;
    --sends information to sorter
    inData <= rwSig & WD3 when (write = '1') else 
    	      readDummyData when (A1'event or A2'event);
    inputAddress <= A3 when (write = '1') else 
    		     A2 when (A2'event) else 
    		     A1 when (A1'event);
    --if reading reports the data to the correct port
    RD1 <= Rport when (inputAddress = A1);
    RD2 <= Rport when (inputAddress = A2);
end;
