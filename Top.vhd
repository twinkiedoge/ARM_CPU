-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CPU is 
end CPU;

architecture synth of CPU is 

component alu is
port(
	srcA : in std_logic_vector(31 downto 0);
	srcB : in std_logic_vector(31 downto 0);
	command : in std_logic_vector(3 downto 0);
	result : out std_logic_vector(31 downto 0);
	flags : out std_logic_vector(3 downto 0) -- NZCV
	);
end component;

component programcounter is
port(
	clk : in std_logic;
	reset : in std_logic;
	branch : in std_logic;
	branchAddr : in std_logic_vector(31 downto 0);
	pc : out unsigned(31 downto 0)
	);
end component;

component regfile is
port(
	clk : in std_logic;
	A1 : in unsigned(3 downto 0); -- Address for port 1 (read 1)
	A2 : in unsigned(3 downto 0); -- Address for port 2 (read 2)
	A3 : in unsigned(3 downto 0); -- Address for port 3 (write 3)
	WE3 : in std_logic; -- Write enable for port 3
	R15 : in std_logic_vector(31 downto 0); -- Passthrough for PC+8
	RD1 : out std_logic_vector(31 downto 0); -- Data result for port 1
	RD2 : out std_logic_vector(31 downto 0); -- Data result for port 2
	WD3 : in std_logic_vector(31 downto 0) -- Data input for port 3
);
end component;

component progrom is
port(
	addr : in unsigned(31 downto 0);
	data : out std_logic_vector(31 downto 0)
	);
end component;

component immextend is
port(
	imm : in std_logic_vector(11 downto 0);
	immout : out std_logic_vector(31 downto 0)
	);
end component;

component add8 is
port(
	x : in unsigned(31 downto 0);
	xplus8 : out unsigned(31 downto 0)
);

component add4 is --STILL NEED TO MAKE COMPONENT!!!--
    port (
      x : in unsigned(31 downto 0);
      xplus4 : out unsigned(31 downto 0)
    );
end;

end component;

component decoder is
port(
	instruction : in std_logic_vector(31 downto 0);
	aluControl : out std_logic_vector(3 downto 0);
	addrA : out unsigned(3 downto 0);
	addrB : out unsigned(3 downto 0);
	addrC : out unsigned(3 downto 0);
	useImm : out std_logic
);
end component;

component ram is
port(
	clk : in std_logic;
	write_enable : in std_logic;
	addr : in unsigned(31 downto 0);
	write_data : in unsigned(31 downto 0);
	read_data : out unsigned(31 downto 0)
);
component end;

--internal
signal PCsig: unsigned(31 downto 0);
signal Instr: std_logic_vector(31 downto 0);
signal RA1: std_logic_vector(3 downto 0);
signal immsig: std_logic_vector(11 downto 0);
signal ExtImm: std_logic_vector(31 downto 0);
signal RD1sig: std_logic_vector(31 downto 0);
signal ALUResult: std_logic_vector(31 downto 0);
signal read_datasig: unsigned(31 downto 0);
signal PCPlus4: std_logic_vector(31 downto 0);
signal PCPlus8: std_logic_vector(31 downto 0);


--control
signal PCSrc: std_logic;



begin

ALUinst: ALU port map(srcA => RD1sig, srcB => ExtImm, command => , result => ALUResult, flags => );
programcounterinst: programcounter port map(clk =>, reset =>, branch =>, branchAddr => , pc => PCsig);
regfileinst: regfile port map(clk =>, A1 => RA1, A2 =>, A3 =>, WE3 => , R15 => PCPlus8, RD1 => RD1sig, RD2 =>, WD3 => read_datasig);
progrominst: progrom port map(addr => PCsig, data => Instr); --assuming "instruction memory" in book is progrom
immextendinst: immextend port map(imm => immsig, immout => ExtImm);
add8inst: add8 port map(x => PCPlus4, xplus8 => PCPlus8);
add4inst: add4 port map(x => PCsig, xplus4 => PCPlus4);
decoderinst: decoder port map(instruction =>, aluControl =>, addrA =>, addrB =>, addrC =>, useImm =>);
raminst: ram port map(clk =>, write_enable =>, addr => ALUResult, write_data =>, read_data => read_datasig)

RA1 => Instr(19 downto 16);
immsig => Instr(11 downto 0);


process(clk)
	begin
    	if PCSrc = '1' then
        	branchAddr => read_datasig;
        else
         	branchAddr => PCPlus4;
        end if;
    end process;
end;
