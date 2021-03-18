----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/16/2021 10:52:29 PM
-- Design Name: 
-- Module Name: CounterMOD6 - Behavioral
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

entity CounterMOD6 is
    Port(clk: in std_logic;
        input: in std_logic := '1';
        output: out std_logic_vector(2 downto 0));
end CounterMOD6;

architecture Behavioral of CounterMOD6 is
    component FFJK 
        Port(J, K, resetN, setN, clk: in std_logic;
                Q, Qnot: out std_logic);
    end component;

signal setN, resetN,q1, notq1, q2, notq2, q3, notq3, inq3: std_logic;
signal q: std_logic_vector(2 downto 0);
begin
   setN <= '1';
   q <= q3&q2&q1;
   resetN <= '0' when q = "110" else '1';
   inq3 <= q1 and q2;
   output <= q;
   FFJK1: FFJK port map(input, input, resetN, setN, clk, q1, notq1);
   FFJK2: FFJK port map(q1, q1, resetN, setN, clk, q2, notq2);
   FFJK3: FFJK port map(inq3, inq3, resetN, setN, clk, q3, notq3);

end Behavioral;
