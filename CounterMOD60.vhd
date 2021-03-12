----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.02.2021 18:21:54
-- Design Name: 
-- Module Name: CounterMOD60 - Behavioral
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

entity CounterSecMOD60 is
    Port (clk: in bit;
          input: in bit:='1';
          seg_uni: out bit_vector(3 downto 0);
          seg_dec: out bit_vector(2 downto 0));
end CounterSecMOD60;

architecture Behavioral of CounterSecMOD60 is
    component CounterMOD10
        Port(clk, input: in bit;
            output: out bit_vector(3 downto 0));
    end component;
    
    component CounterMOD6
        Port(clk, input: in bit;
            output: out bit_vector(2 downto 0));
    end component;
    
signal inputM6: bit;
signal setN, resetN: bit := '1';
signal Qout6: bit_vector(2 downto 0);
signal Qout10: bit_vector(3 downto 0);

begin
    seg_uni <= Qout10;
    seg_dec <= Qout6;
    inputM6 <= Qout10(3) and Qout10(1);
    CM10: CounterMOD10 port map(clk, input, Qout10);
    CM6:  CounterMOD6  port map(inputM6, input, Qout6);
end Behavioral;
