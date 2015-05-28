library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity port_buttons is
	Port ( r           : in  std_logic;
	       clk         : in  std_logic;
	       enable      : in  std_logic;
	       port_out    : out std_logic_vector (7 downto 0);
	       buttons_in  : in  std_logic_vector (2 downto 0)
       );
end port_buttons;

architecture Behavioral of port_buttons is
	signal mem : std_logic_vector (2 downto 0);
begin
	port_out <= "00000" & mem when r = '1' else "ZZZZZZZZ";

	read_proc: process(clk)
	begin
		if falling_edge(clk) and enable='1' and r='1' then
			mem <= buttons_in;
		end if;
	end process;
end Behavioral;
