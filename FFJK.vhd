----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/16/2021 10:50:51 PM
-- Design Name: 
-- Module Name: FFJK - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AMPM is
    Port(J, K, resetN, setN, clk: in std_logic;
            Q, Qnot: out std_logic);
end AMPM;

architecture Behavioral of AMPM is
signal q_i: std_logic := '0';
begin
    Q    <= q_i;
    Qnot <= not q_i;
    process(clk, resetN, setN)
    begin
        if resetN = '0' then q_i <= '0';
        elsif setN= '0' then q_i <= '1';
        elsif clk'event and clk = '1' then 
            if (j /= k) then
               q_i <=  j; 
            elsif (j = '1' and k = '1') then 
               q_i <= not q_i; 
            end if; 
        end if;
    end process;

end Behavioral;
