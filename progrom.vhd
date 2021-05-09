library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;



entity progrom is
	port (
		addr : in unsigned(31 downto 0);
		data : out std_logic_vector(31 downto 0)
	);
end; 

  
architecture synth of progrom is

type ROM_type is array(0 to 31) of std_logic_vector(31 downto 0); 

impure function init_rom_bin return ROM_type is
	file text_file : text open read_mode is "rom_content_bin.txt"; 
	variable text_line : line;
	variable rom_content : ROM_type; 
	variable bv : bit_vector(rom_content(0)'range);
begin
	for i in 0 to 31 loop
		readline(text_file, text_line);
		read(text_line, bv);
		rom_content(i) := To_StdLogicVector(bv);
	end loop;
	return rom_content;
end function; 

signal ROM : ROM_type := init_rom_bin;


begin
	data <= ROM (to_integer(addr));
end; 
