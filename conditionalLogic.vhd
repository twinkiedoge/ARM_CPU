library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity conditionalLogic is
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
end conditionalLogic;


architecture synth of conditionalLogic is
signal CondEx : std_logic;
signal Flags : std_logic_vector(3 downto 0) := ALUFlags;

begin    	
	--checking condition
	CondEx <= '1' when ((cond = "0000" and ALUFlags(2) = '1') or
	                   (cond = "0010" and ALUFlags(1) = '1') or
	                   (cond = "0100" and ALUFlags(3) = '1') or
	                   (cond = "0110" and ALUFlags(0) = '1') or
                           (cond = "1000" and (ALUFlags(2) = '0' and ALUFlags(1) = '1')) or
                           (cond = "1010" and ((ALUFlags(3) = '1' and ALUFlags(0) = '1') or (ALUFlags(3) = '0' and ALUFlags(0) = '0'))) or
                           (cond = "1100" and (ALUFlags(2) = '0' and ((ALUFlags(3) = '1' and ALUFlags(0) = '1') or (ALUFlags(3) = '0' and ALUFlags(0) = '0')))) or
                           --(cond = "1110") or    --AL (always) has no CPSR conditions?
                           (cond = "0001" and ALUFlags(2) = '0') or
                           (cond = "0011" and ALUFlags(1) = '0') or
                           (cond = "0101" and ALUFlags(3) = '0') or
                           (cond = "0111" and ALUFlags(0) = '0') or
                           (cond = "1001" and (ALUFlags(2) = '1' or ALUFlags(1) = '0')) or
                           (cond = "1011" and ((ALUFlags(3) = '1' and ALUFlags(0) = '0') or (ALUFlags(3) = '0' and ALUFlags(0) = '1'))) or
                           (cond = "1101" and (ALUFlags(2) = '1' or ((ALUFlags(3) = '1' and ALUFlags(0) = '0') or (ALUFlags(3) = '0' and ALUFlags(0) = '1'))))) else '0';
                
	--disables memory, register, and PC if condition is not
	--       executed, else sends through the info
	memWrite <= memW and CondEx;
	regWrite <= regW and CondEx;
	PCSrc <= PCS and CondEx;
    	
    	--saving flags (CPSR)
	process(clk)
	begin 
	    	if (rising_edge(clk)) then 
	        	if (FlagW(1) = '1' and CondEx = '1') then
		        	Flags(3 downto 2) <= ALUFlags (3 downto 2);
	    		end if;
	    		if (FlagW(0) = '1' and CondEx = '1') then 
	            		Flags (1 downto 0) <= ALUFLags (1 downto 0);
	            	end if;
	        end if;
	end process;
    
    
    -- flagW - tells if/what aluflags should be saved
    --	       = "00" do NOT save the aluflags
    --         = "10" save the C and V flags
    --         = "11" save all flags
    
     
    -- condEx - checks if the condition is met - ie do the flags
    --          match the expected flags that would come with the cond
end synth;
