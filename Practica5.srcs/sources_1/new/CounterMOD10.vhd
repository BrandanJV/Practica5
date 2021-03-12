----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.02.2021 17:41:32
-- Design Name: 
-- Module Name: CounterMOD10 - Behavioral
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

entity CounterMOD10 is
    Port(clk: in bit;
        input: in bit := '1';
        output: out bit_vector(3 downto 0));
end CounterMOD10;

architecture Behavioral of CounterMOD10 is
    component FFJK
        Port(J, K, resetN, setN, clk: in bit;
            Q, Qnot: out bit);
    end component;
signal q1, notq1, q2, notq2, q3, notq3, inq3, q4, notQ4, inq4, resetN, setN: bit;
begin
    setN <= '1';
    resetN <= '0' when q4&q3&q2&q1 = "1010" else '1';
    inq3 <= q1 and q2;
    inq4 <= inq3 and q3;
    output <= q4&q3&q2&q1;
    FFJK1: FFJK port map(input, input, resetN, setN, clk, q1, notq1);
    FFJK2: FFJK port map(q1, q1, resetN, setN, clk, q2, notq2);
    FFJK3: FFJK port map(inq3, inq3, resetN, setN, clk, q3, notq3);
    FFJK4: FFJK port map(inq4, inq4, resetN, setN, clk, q4, notq4);
end Behavioral;
