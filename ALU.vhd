library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
    port(
        srcA: in std_logic_vector(31 downto 0);
        srcB: in std_logic_vector(31 downto 0);
        command: in std_logic_vector(3 downto 0);
        result: out std_logic_vector(31 downto 0);
        flags: out std_logic_vector(3 downto 0) -- NZCV
    );
end;

architecture synth of alu is 

signal resultsig: std_logic_vector(31 downto 0);
signal carrysig: unsigned(32 downto 0);
signal carrysigsign: signed(32 downto 0);

begin
     process(all) is
	 begin
	 
		result <= (srcA and srcB) when(command = "0000") else
		(std_logic_vector(signed(srcA) - signed(srcB))) when(command = "0010") else
		(std_logic_vector(signed(srcB) - signed(srcA))) when(command = "0011") else
		(std_logic_vector(signed(srcA) + signed(srcB))) when(command = "0100") else
		(srcA or srcB) when(command = "1100") else
		(srcB) when(command = "1101");
     
		flags(2) <= ('1') when (resultsig = (resultsig'range => '0')) else ('0'); -- zero
		flags(3) <= ('1') when (to_integer(signed(resultsig)) < 0) else ('0'); -- negative
     
		--carry
		--SUB
        if command = "0010" then
			if( srcA(31) = srcB(31) ) then
            	flags(1) <= '0'; --carry will never happen for subtraction with two integers of same sign
     		elsif( srcA(31) = '1' ) then
            	carrysigsign <= (signed(srcA(31) & srcA)) - (signed(srcB(31) & srcB));
                if ( carrysigsign(32) = '1' ) then
                	flags(1) <= '1';
                else 
                	flags(1) <= '0';
                end if;   
             elsif( srcB(31) = '1' ) then
             	carrysig <= unsigned(signed('0' & srcA) - signed(srcB(31) & srcB)); 
             	if ( carrysig(32) = '1' or carrysig(31) = '1') then
                	flags(1) <= '1';
                else 
                	flags(1) <= '0';
                end if;
             else
             	flags(1) <= '0';
             end if;
             
             
        --RSB     
		elsif command = "0011" then
			if( srcA(31) = srcB(31) ) then
            	flags(1) <= '0'; --carry will never happen for subtraction with two integers of same sign
     		elsif( srcB(31) = '1' ) then
            	carrysigsign <= (signed(srcB(31) & srcB)) - (signed(srcA(31) & srcA));
                if ( carrysigsign(32) = '1' ) then
                	flags(1) <= '1';
                else 
                	flags(1) <= '0';
                end if;   
             elsif( srcA(31) = '1' ) then
             	carrysig <= unsigned(signed('0' & srcB) - signed(srcA(31) & srcA)); 
             	if ( carrysig(32) = '1' or carrysig(31) = '1') then
                	flags(1) <= '1';
                else 
                	flags(1) <= '0';
                end if;
             else
             	flags(1) <= '0';
             end if;
             
             
		elsif command = "0100" then
		if ((to_integer(signed(srcA)) + to_integer(signed(srcB))) > 2147483646) then
				flags(1) <= '1';
			else 
				flags(1) <= '0';
			end if;
		else
			flags(1) <= '0';
		end if;  
		
		--overflow
		--SUB
        if (command = "0010") then
			if( srcA(31) /= srcB(31) ) then
            	if( srcA(31) /= resultsig(31) ) then
                	flags(0) <= '1';
                else
                	flags(0) <= '0';
                end if;
            else
				flags(0) <= '0';
			end if;

		--RSB
		elsif (command = "0011") then
			if( srcA(31) /= srcB(31) ) then
            	if( srcB(31) /= resultsig(31) ) then
                	flags(0) <= '1';
                else
                	flags(0) <= '0';
                end if;
            else
				flags(0) <= '0';
			end if;
            
		--ADD	
		elsif (command = "0100") then
			if( srcA(31) /= srcB(31) ) then
				if( resultsig(31) /= srcB(31) ) then
					flags(0) <= '1';
				else
					flags(0) <= '0';
				end if;
			else
				flags(0) <= '0';
			end if;
		else
			flags(0) <= '0';
		end if;
		
		
		resultsig <= result;
	end process;
end;
