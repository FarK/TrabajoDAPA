-------------------------------------------------------------------------------
-- This file is part of the Basys2 peripherals project
-- It is distributed under GNU General Public License
-- See at http://www.gnu.org/licenses/gpl.html 
-- Copyright (C) 2012 Paulino Ruiz de Clavijo Vázquez <paulino@dte.us.es>
-- You can get more info at http://www.dte.us.es/id2
--------------------------------------------------------------------------------
-- Date:     29-04-2012
-- Revision: 1
--*--------------------------------------------------------------------------*--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity port_switches_basys2 is
Port ( r 			  : in  std_logic;
		 clk 		     : in  std_logic;
		 enable 	     : in  std_logic;
       port_out 	  : out  std_logic_vector (7 downto 0);
       switches_in  : in  std_logic_vector (7 downto 0));
end port_switches_basys2;

architecture Behavioral of port_switches_basys2 is

signal mem : std_logic_vector (7 downto 0);

begin

port_out <= mem when r = '1' else "ZZZZZZZZ";

read_proc: process(clk)
begin
  if falling_edge(clk) and enable='1' and r='1' then
		mem <= switches_in;
  end if;
end process;

end Behavioral;