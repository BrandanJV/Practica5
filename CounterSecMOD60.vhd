----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/16/2021 11:46:46 PM
-- Design Name: 
-- Module Name: CounterSecMOD60 - Behavioral
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

entity CounterSecMOD60 is
    Port (clk: in std_logic;
          input: in std_logic:='1';
          seg_uni: out std_logic_vector(3 downto 0);
          seg_dec: out std_logic_vector(2 downto 0));
end CounterSecMOD60;

architecture Behavioral of CounterSecMOD60 is
    component CounterMOD10 
        Port(clk: in std_logic;
            input: in std_logic := '1';
            output: out std_logic_vector(3 downto 0));
    end component;
    
    component CounterMOD6
    Port(clk: in std_logic;
           input: in std_logic := '1';
           output: out std_logic_vector(2 downto 0));
    end component;
   
    signal inputM6: std_logic;
    signal setN, resetN: std_logic := '1';
    signal Qout6: std_logic_vector(2 downto 0);
    signal Qout10: std_logic_vector(3 downto 0);
begin
    seg_uni <= Qout10;
    seg_dec <= Qout6;
    inputM6 <= Qout10(3) and Qout10(1);
    CM10: CounterMOD10 port map(clk, input, Qout10);
    CM6:  CounterMOD6  port map(inputM6, input, Qout6);
end Behavioral;
