----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2021 12:01:10 AM
-- Design Name: 
-- Module Name: CounterHrsMOD12 - Behavioral
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

entity CounterHrsMOD12 is
    Port (clk: in std_logic;
          input: in std_logic:= '1';
          hrs_uni: out std_logic_vector(3 downto 0);
          hrs_dec: out std_logic);
end CounterHrsMOD12;

architecture Behavioral of CounterHrsMOD12 is
    component FFJK
        Port(J, K, resetN, setN, clk: in std_logic;
            Q, Qnot: out std_logic);
    end component;
    
    signal notq1, notq2, notq3, notq4, notq5, setFF3, setFF4, setFF5, q_dec: std_logic;
    signal set_uni, reset_uni, set_dec, reset_dec: std_logic:='1';
    signal q_uni: std_logic_vector(3 downto 0);
begin
    hrs_dec <= q_dec;
    hrs_uni <= q_uni;
    setFF3  <= q_uni(0) and q_uni(1);
    setFF4  <= setFF3 and q_uni(2);
    setFF5  <= q_uni(0) and q_uni(3);
    reset_uni <= '0' when q_uni = "1010" or q_dec & q_uni = "10010" else '1';
    reset_dec <= '0' when q_dec & q_uni = "10010" else '1';
    FFJK1: FFJK port map(input, input, reset_uni, set_uni, clk,  q_uni(0), notq1);
    FFJK2: FFJK port map(q_uni(0), q_uni(0), reset_uni, set_uni, clk,  q_uni(1), notq2);
    FFJK3: FFJK port map(setFF3, setFF3, reset_uni, set_uni, clk,  q_uni(2), notq3);
    FFJK4: FFJK port map(setFF4, setFF4, reset_uni, set_uni, clk,  q_uni(3), notq4);
    FFJK5: FFJK port map(setFF5, setFF5, reset_dec, set_dec, clk, q_dec, notq5);
end Behavioral;
