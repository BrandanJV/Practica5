----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2021 12:10:47 AM
-- Design Name: 
-- Module Name: ALARM - Behavioral
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

entity ALARM is
    Port(clk_input: in std_logic;
            PM: out std_logic;
            D71 : out std_logic_vector (7 downto 0);
            D7A : out std_logic_vector (7 downto 0));
end ALARM;

architecture Behavioral of ALARM is
    Component AMPM 
        Port(J, K, resetN, setN, clk: in std_logic;
                Q, Qnot: out std_logic);
    end component;
    
    Component CounterHrsMOD12 
        Port (clk: in std_logic;
              input: in std_logic:= '1';
              hrs_uni: out std_logic_vector(3 downto 0);
              hrs_dec: out std_logic);
    end component;
    
    Component CounterMinMOD60
        Port (clk: in std_logic;
                input: in std_logic:= '1';
                min_uni: out std_logic_vector(3 downto 0);
                min_dec: out std_logic_vector(2 downto 0));
    end component;
    
    Component CounterSecMOD60 is
        Port (clk: in std_logic;
              input: in std_logic:='1';
              seg_uni: out std_logic_vector(3 downto 0);
              seg_dec: out std_logic_vector(2 downto 0));
    end component;
    
    Component Seg7 is
        Port(ck : in  std_logic;                          -- 100MHz system clock
            number : in  std_logic_vector (63 downto 0); -- eight digit number to be displayed
            seg : out  std_logic_vector (7 downto 0);    -- display cathodes
            an : out  std_logic_vector (7 downto 0));  
    end component;
    
    signal input: std_logic := '1';
    signal clk_divisor: integer := 0;
    signal startHrsCounter, startMinCounter, AM_PM, AM, internal_hrs_dec, clk_in: std_logic;
    signal internal_min_dec, internal_sec_dec: std_logic_vector(2 downto 0);
    signal internal_hrs_uni, internal_min_uni, internal_sec_uni: std_logic_vector(3 downto 0);
    signal d7s: std_logic_vector(63 downto 0) := "1111111111111111111111111111111100000000000000000000000000000000";

begin
    
    process(clk_in, clk_input)
    begin
        if clk_input'event and clk_input = '1' then
            clk_divisor <= clk_divisor + 1;
           --divisor: if clk_divisor <= 50000000 then
                
                divisor: if clk_divisor = 199999998 then
                    clk_in <= '1';
                    clk_divisor <= 0;
                else
                    clk_in <= '0';
                end if;    
            --end if;
          end if;
         
        if CLK_IN'event and clk_in = '1' then
            startMinCounter <= internal_sec_dec(2) and internal_sec_dec(0) and internal_sec_uni(3) and internal_sec_uni(0); 
        
            startHrsCounter <=  internal_min_dec(2) and internal_min_dec(0) and internal_min_uni(3) and internal_min_uni(0) and 
                                internal_sec_dec(2) and internal_sec_dec(0) and internal_sec_uni(3) and internal_sec_uni(0); 
                                    
            AM_PM           <=  internal_hrs_dec and internal_hrs_uni(0) and internal_min_dec(2) and internal_min_dec(0) and internal_min_uni(3) 
                                and internal_min_uni(0) and internal_sec_dec(2) and internal_sec_dec(0) and internal_sec_uni(3) and internal_sec_uni(0); 
        end if;
        
    
        case (internal_min_uni) is
                        when "0000" => d7s(7 downto 0) <= "11000000";
                        when "0001" => d7s(7 downto 0) <= "11111001";
                        when "0010" => d7s(7 downto 0) <= "10100100";
                        when "0011" => d7s(7 downto 0) <= "10110000";
                        when "0100" => d7s(7 downto 0) <= "10011001";
                        when "0101" => d7s(7 downto 0) <= "10010010";
                        when "0110" => d7s(7 downto 0) <= "10000010";
                        when "0111" => d7s(7 downto 0) <= "11111000";
                        when "1000" => d7s(7 downto 0) <= "10000000";
                        when "1001" => d7s(7 downto 0) <= "10010000";
                        when others => d7s(7 downto 0) <= "11111111";
                        end case;
       case (internal_min_dec) is
                        when "000" => d7s(15 downto 8) <= "11000000";
                        when "001" => d7s(15 downto 8) <= "11111001";
                        when "010" => d7s(15 downto 8) <= "10100100";
                        when "011" => d7s(15 downto 8) <= "10110000";
                        when "100" => d7s(15 downto 8) <= "10011001";
                        when "101" => d7s(15 downto 8) <= "10010010";
                        --when "0110" => d7s(15 downto 8) <= "10000010";
                        --when "0111" => d7s(15 downto 8) <= "11111000";
                        --when "1000" => d7s(15 downto 8) <= "10000000";
                        --when "1001" => d7s(15 downto 8) <= "10010000";
                        when others => d7s(15 downto 8) <= "11111111";
                        end case;                      
                        
        
         
        case (internal_hrs_uni) is
                        when "0000" => d7s(23 downto 16) <= "11000000";
                        when "0001" => d7s(23 downto 16) <= "11111001";
                        when "0010" => d7s(23 downto 16) <= "10100100";
                        when "0011" => d7s(23 downto 16) <= "10110000";
                        when "0100" => d7s(23 downto 16) <= "10011001";
                        when "0101" => d7s(23 downto 16) <= "10010010";
                        when "0110" => d7s(23 downto 16) <= "10000010";
                        when "0111" => d7s(23 downto 16) <= "11111000";
                        when "1000" => d7s(23 downto 16) <= "10000000";
                        when "1001" => d7s(23 downto 16) <= "10010000";
                        when others => d7s(23 downto 16) <= "11111111";
                        end case;
            
        
        
        case (internal_hrs_dec) is
                        when '0' => d7s(31 downto 24) <= "11000000";
                        when '1' => d7s(31 downto 24) <= "11111001";
                        --when "010" => d7s(15 downto 8) <= "10100100";
                        --when "011" => d7s(15 downto 8) <= "10110000";
                        --when "100" => d7s(15 downto 8) <= "10011001";
                        --when "101" => d7s(15 downto 8) <= "10010010";
                        --when "0110" => d7s(15 downto 8) <= "10000010";
                        --when "0111" => d7s(15 downto 8) <= "11111000";
                        --when "1000" => d7s(15 downto 8) <= "10000000";
                        --when "1001" => d7s(15 downto 8) <= "10010000";
                        when others => d7s(31 downto 24) <= "11111111";
                        end case;
    end process;

    CSM60:      CounterSecMOD60 port map (clk_in, input, internal_sec_uni, internal_sec_dec);
    CMM60:      CounterMinMOD60 port map (clk_in, input, internal_min_uni, internal_min_dec);
    CHM12:      CounterHrsMOD12 port map (startHrsCounter, input, internal_hrs_uni, internal_hrs_dec);
    PMLED:      AMPM port map (input, input, '1', '1', AM_PM, PM, AM);
    Disp7seg:   Seg7 port map(clk_input, d7s, D7A, D71);

end Behavioral;
