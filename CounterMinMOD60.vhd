----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/16/2021 11:52:58 PM
-- Design Name: 
-- Module Name: CounterMinMOD60 - Behavioral
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

entity CounterMinMOD60 is
    Port (clk: in std_logic;
            input: in std_logic:= '1';
            min_uni: out std_logic_vector(3 downto 0);
            min_dec: out std_logic_vector(2 downto 0));
end CounterMinMOD60;

architecture Behavioral of CounterMinMOD60 is
    Component CounterSecMOD60
        Port (clk: in std_logic;
              input: in std_logic:='1';
              seg_uni: out std_logic_vector(3 downto 0);
              seg_dec: out std_logic_vector(2 downto 0));
    end component;
    
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


signal inputM6, inputM10: std_logic;
signal setN, resetN: std_logic := '1';
signal Qout6, seg_dec: std_logic_vector(2 downto 0);
signal Qout10, seg_uni: std_logic_vector(3 downto 0);

begin
    min_dec    <= Qout6;
    min_uni    <= Qout10;
    inputM6    <= Qout10(3) and Qout10(1);
    process(clk)
    begin
        if CLK'event and clk = '1' then
            inputM10<= seg_dec(2) and seg_dec(0) and seg_uni(3) and seg_uni(0); 
        end if;
    end process;
    CSM60: CounterSecMOD60 port map(clk, input, seg_uni, seg_dec);
    CM10:  CounterMOD10 port map(inputM10, input, Qout10);
    CM6:   CounterMOD6  port map(inputM6, input,  Qout6);

end Behavioral;
