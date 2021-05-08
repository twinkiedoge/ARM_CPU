library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity sorter2 is 
	port (
	inputAddress : in unsigned (3 downto 0);
        inputData : in std_logic_vector(32 downto 0);
        Rport : out std_logic_vector(31 downto 0)
	);
end sorter2;


architecture synth of sorter2 is 
component reg is
  port(
    addressIn : in unsigned (3 downto 0);
    dataIn : in std_logic_vector(31 downto 0);
    addressOut : out unsigned (3 downto 0);
    dataOut : out std_logic_vector(31 downto 0)
  );
end component;

signal address0, address1, address2, address3, address4, address5, address6, address7, address8 : unsigned(3 downto 0);
signal address9, address10, address11, address12, address13, address14, address15 : unsigned(3 downto 0);

signal dataIn0, dataIn1, dataIn2, dataIn3, dataIn4, dataIn5, dataIn6, dataIn7, dataIn8 : std_logic_vector(31 downto 0);
signal dataIn9, dataIn10, dataIn11, dataIn12, dataIn13, dataIn14, dataIn15, dataOut : std_logic_vector(31 downto 0);

signal dataOut0, dataOut1, dataOut2, dataOut3, dataOut4, dataOut5, dataOut6, dataOut7, dataOut8 : std_logic_vector(31 downto 0);
signal dataOut9, dataOut10, dataOut11, dataOut12, dataOut13, dataOut14, dataOut15 : std_logic_vector(31 downto 0);

signal inter : std_logic_vector(31 downto 0);
--all the registers
begin 
  r0 : reg port map(addressIn => "0000", dataIn => dataIn0, addressOut => address0, dataOut => dataOut0);
  r1 : reg port map(addressIn => "0001", dataIn => dataIn1, addressOut => address1, dataOut => dataOut1);
  r2 : reg port map(addressIn => "0010", dataIn => dataIn2, addressOut => address2, dataOut => dataOut2);
  r3 : reg port map(addressIn => "0011", dataIn => dataIn3, addressOut => address3, dataOut => dataOut3);
  r4 : reg port map(addressIn => "0100", dataIn => dataIn4, addressOut => address4, dataOut => dataOut4);
  r5 : reg port map(addressIn => "0101", dataIn => dataIn5, addressOut => address5, dataOut => dataOut5);
  r6 : reg port map(addressIn => "0110", dataIn => dataIn6, addressOut => address6, dataOut => dataOut6);
  r7 : reg port map(addressIn => "0111", dataIn => dataIn7, addressOut => address7, dataOut => dataOut7);
  r8 : reg port map(addressIn => "1000", dataIn => dataIn8, addressOut => address8, dataOut => dataOut8);
  r9 : reg port map(addressIn => "1001", dataIn => dataIn9, addressOut => address9, dataOut => dataOut9);
  r10 : reg port map(addressIn => "1010", dataIn => dataIn10, addressOut => address10, dataOut => dataOut10);
  r11 : reg port map(addressIn => "1011", dataIn => dataIn11, addressOut => address11, dataOut => dataOut11);
  r12 : reg port map(addressIn => "1100", dataIn=> dataIn12, addressOut => address12, dataOut => dataOut12);
  r13 : reg port map(addressIn => "1101", dataIn => dataIn13, addressOut => address13, dataOut => dataOut13);
  r14 : reg port map(addressIn => "1110", dataIn => dataIn14, addressOut => address14, dataOut => dataOut14);
  r15 : reg port map(addressIn => "1111", dataIn => dataIn15, addressOut => address15, dataOut => dataOut15);

  
    process(all)
    begin 
    --write
    	inter <= inputData(31 downto 0);
	dataIn0 <= inter when (inputAddress = address0 and inputData(32) = '1');    	
	dataIn1 <= inter when (inputAddress = address1 and inputData(32) = '1');
	dataIn2 <= inter when (inputAddress = address2 and inputData(32) = '1');
	dataIn3 <= inter when (inputAddress = address3 and inputData(32) = '1');
	dataIn4 <= inter when (inputAddress = address4 and inputData(32) = '1');
	dataIn5 <= inter when (inputAddress = address5 and inputData(32) = '1');
	dataIn6 <= inter when (inputAddress = address6 and inputData(32) = '1');
	dataIn7 <= inter when (inputAddress = address7 and inputData(32) = '1');
	dataIn8 <= inter when (inputAddress = address8 and inputData(32) = '1');
	dataIn9 <= inter when (inputAddress = address9 and inputData(32) = '1');
	dataIn10 <= inter when (inputAddress = address10 and inputData(32) = '1');
	dataIn11 <= inter when (inputAddress = address11 and inputData(32) = '1');
	dataIn12 <= inter when (inputAddress = address12 and inputData(32) = '1');
	dataIn13 <= inter when (inputAddress = address13 and inputData(32) = '1');
	dataIn14 <= inter when (inputAddress = address14 and inputData(32) = '1');
	dataIn15 <= inter when (inputAddress = address15 and inputData(32) = '1');
	
     
     --read
     Rport <= dataOut0 when (inputData(32) = '0' and inputAddress = address0) else
     		  dataOut1 when (inputData(32) = '0' and inputAddress = address1) else 
    	      dataOut2 when (inputData(32) = '0' and inputAddress = address2) else 
    	      dataOut3 when (inputData(32) = '0' and inputAddress = address3) else 
    	      dataOut4 when (inputData(32) = '0' and inputAddress = address4) else 
    	      dataOut5 when (inputData(32) = '0' and inputAddress = address5) else 
    	      dataOut6 when (inputData(32) = '0' and inputAddress = address6) else 
    	      dataOut7 when (inputData(32) = '0' and inputAddress = address7) else 
    	      dataOut8 when (inputData(32) = '0' and inputAddress = address8) else 
    	      dataOut9 when (inputData(32) = '0' and inputAddress = address9) else 
    	      dataOut10 when (inputData(32) = '0' and inputAddress = address10) else 
    	      dataOut11 when (inputData(32) = '0' and inputAddress = address11) else 
    	      dataOut12 when (inputData(32) = '0' and inputAddress = address12) else 
    	      dataOut13 when (inputData(32) = '0' and inputAddress = address13) else  
    	      dataOut14 when (inputData(32) = '0' and inputAddress = address14) else  
    	      dataOut15 when (inputData(32) = '0' and inputAddress = address15);
	
     end process;
end synth;