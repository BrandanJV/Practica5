----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Izel Molina & Brandan Jimenez
-- 
-- Create Date: 26.02.2021 19:51:41
-- Design Name: Alarm
-- Module Name: Alarm - Behavioral
-- Project Name: Practica 5
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

entity Alarm is
        Port(clk_in: in bit;
            input: in bit := '1';
            hrs_dec: out bit;
            hrs_uni, min_uni, seg_uni: out bit_vector(3 downto 0);
            min_dec, seg_dec: out bit_vector(2 downto 0));
end Alarm;

architecture Behavioral of Alarm is

    component CounterHrsMOD12
        Port(clk: in bit;
            input: in bit:= '1';
            hrs_uni: out bit_vector(3 downto 0);
            hrs_dec: out bit);
    end component;
    
    component CounterMinMOD60
        Port(clk, input: in bit;
             min_uni: out bit_vector(3 downto 0);
             min_dec: out bit_vector(2 downto 0));
    end component;
    
    component CounterSecMOD60
        Port(clk, input: in bit;
            seg_uni: out bit_vector(3 downto 0);
            seg_dec: out bit_vector(2 downto 0));
    end component;
signal startHrsCounter: bit;
signal internal_min_dec, internal_sec_dec: bit_vector(2 downto 0);
signal internal_min_uni, internal_sec_uni: bit_vector(3 downto 0);
begin
    process(clk_in)
    begin
        if CLK_IN'event and clk_in = '1' then
            startHrsCounter<=   internal_min_dec(2) and internal_min_dec(0) and internal_min_uni(3) and internal_min_uni(0) and 
                                internal_sec_dec(2) and internal_sec_dec(0) and internal_sec_uni(3) and internal_sec_uni(0); 
        end if;
    end process;    
    seg_uni <= internal_sec_uni;
    seg_dec <= internal_sec_dec;
    min_uni <= internal_min_uni;
    min_dec <= internal_min_dec;
    CSM60: CounterSecMOD60 port map (clk_in, input, internal_sec_uni, internal_sec_dec);
    CMM60: CounterMinMOD60 port map (clk_in, input, internal_min_uni, internal_min_dec);
    CHM12: CounterHrsMOD12 port map (startHrsCounter, input, hrs_uni, hrs_dec);
end Behavioral;
