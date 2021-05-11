
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
	ImmSrc: in std_logic_vector(1 downto 0); 
    immout : out std_logic_vector(31 downto 0)
	);
end component;

component add8 is
port(
	x : in unsigned(31 downto 0);
	xplus8 : out unsigned(31 downto 0)
);


end component;


component mainDecoder is
port(
	func : in std_logic_vector(5 downto 0);
    op : in std_logic_vector(1 downto 0);
    Rd : in std_logic_vector(3 downto 0);
    B : out std_logic;
    memtoReg : out std_logic;
    memW : out std_logic;
    regW : out std_logic;
    ALUSrc : out std_logic;
    immSrc : out std_logic_vector(1 downto 0);
    ALUOp : out std_logic;
    regSrc : out std_logic_vector(1 downto 0);
    PCS : out std_logic
);
end component;

component conditionalLogic is
port(
    cond : in std_logic_vector(3 downto 0);
    ALUFlags : in std_logic_vector(3 downto 0); 
    clk : in std_logic;
    FlagW : in std_logic_vector(1 downto 0); --from ALU decoder
    memW : in std_logic; -- from main decoder
    regW : in std_logic; -- from main decoder
    PCS : in std_logic;
    PCSrc : out std_logic;
    memWrite : out std_logic;
    regWrite : out std_logic
);
end component;

component ALUDecoder is
port(
	func : in std_logic_vector(5 downto 0);
    ALUOp : in std_logic;
    ALUControl : out std_logic_vector(3 downto 0);
    FlagW : out std_logic_vector(1 downto 0)
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

component branch is
port(
	PC8 : in std_logic_vector(31 downto 0);
	instruction : in std_logic_vector(31 downto 0);
	PC : out std_logic_vector(31 downto 0)
);
end component;


--internal (specced by textbook)
signal PCsig: unsigned(31 downto 0);
signal Instr: std_logic_vector(31 downto 0);
signal RA1: std_logic_vector(3 downto 0);
signal RA2: std_logic_vector(3 downto 0);
signal RA3: std_logic_vector(3 downto 0);
signal immsig: std_logic_vector(23 downto 0);
signal ExtImm: std_logic_vector(31 downto 0);
signal RD1sig: std_logic_vector(31 downto 0);
signal ALUResult: std_logic_vector(31 downto 0);
signal read_datasig: unsigned(31 downto 0);
signal PCPlus8: std_logic_vector(31 downto 0);
signal WriteData: unsigned(31 downto 0);
signal ALUFlags: std_logic_vector(3 downto 0); 
signal ALUControlsig: std_logic_vector(3 downto 0);
signal Opsig: std_logic_vector(1 downto 0);

--internal (not specced by textbook)
signal srcBsig: std_logic_vector(31 downto 0);
signal condsig: std_logic_vector(3 downto 0);
signal ALUOpsig: std_logic;
signal funct: std_logic_vector(5 downto 0); 
signal Rdsig: std_logic_vector(3 downto 0); 
signal FlagWsig :  std_logic_vector(1 downto 0);
signal memWsig : std_logic;
signal regWsig : std_logic;
signal PCSsig: std_logic;
signal branchAddr : std_logic_vector(31 downto 0);
signal reset : std_vector := '1';

--control
signal PCSrcsig: std_logic;
signal MemtoRegsig: std_logic;
signal RegSrc: std_logic;
signal ALUSrcsig: std_logic;
signal ImmSrcsig: std_logic_vector(1 downto 0); 
signal regWritesig: std_logic;
signal memWritesig : std_logic;
signal regSrcsig: std_logic_vector(1 downto 0);




begin

ALUinst: ALU port map(srcA => RD1sig, srcB => srcBsig, command => ALUControlsig, result => ALUResult, flags => ALUFlags);

programcounterinst: programcounter port map(clk => clk, reset => reset, branch => B, branchAddr => , pc => PCsig);

regfileinst: regfile port map(clk =>, A1 => RA1, A2 => , A3 => RA3, WE3 => regWritesig, R15 => PCPlus8, RD1 => RD1sig, RD2 => WriteData, WD3 => read_datasig);

progrominst: progrom port map(addr => PCsig, data => Instr); --assuming "instruction memory" in book is progrom

immextendinst: immextend port map(imm => immsig, ImmSrc => ImmSrcsig, immout => ExtImm);

add8inst: add8 port map(x => PCsig, xplus8 => PCPlus8);

raminst: ram port map(clk =>, write_enable => memWritesig, addr => ALUResult, write_data => WriteData, read_data => read_datasig);

conditionalLogicinst: conditionalLogic port map(cond => condsig, ALUFlags => ALUFlags, clk => clk, FlagW => FlagWsig, memW => memWsig, regW => regWsig, PCS => PCSsig, PCSrc => PCSrcsig, memWrite => memWritesig, regWrite => regWritesig);

ALUDecoderinst: ALUDecoder port map(func => funct, ALUOp => ALUOpsig, ALUControl => ALUControlsig, FlagW => FlagWsig); 

mainDecoderinst: mainDecoder port map(func => funct, op => Opsig, Rd => Rdsig, memtoReg => MemtoRegsig, memW => memWsig, regW => regWsig, ALUSrc => ALUSrcsig, immSrc => ImmSrcsig, ALUOp => ALUOpsig, PCS =>PCSsig);

branchinst : branch port map(PC8 => PCPlus8, instruction => Instruc, PC => branchAddr);

RA3 => Instr(15 downto 12);
immsig => Instr(23 downto 0);
condsig => Instr(31 downto 28); 
funct => Instr(25 downto 20);
Opsig => Instr(27 downto 26); 
Rdsig => Instr(15 downto 12);

--so far at figure 7.11
process(all)
    begin
    reset = '0'; --turns of pc reset at the begining
    	--program counter input
    	if PCSrcsig = '1' then
            if MemtoRegsig = '1' then
            	branchAddr => read_datasig;
            else
            	branchAddr => ALUResult;
            end if;
        end if;
        
        --register input port 2 
        if RegSrcsig(1) = '1' then
        	RA2 => RA3;
        else
        	RA2 => Instr(3 downto 0);
        end if;
        
        --register input port 1
        if RegSrcsig(0) = '1' then
        	RA1 => "1110";
        else
        	RA1 => Instr(19 downto 16); 
        
        --ALU input for second source
        if ALUSrcsig = '1' then
        	srcBsig => ExtImm;
        else
        	srcBsig => WriteData;
        end if;
        	
    end process;
end;
