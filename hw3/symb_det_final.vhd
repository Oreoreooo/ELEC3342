----------------------------------------------------------------------------------
-- Course: ELEC3342
-- Module Name: mucodec - Behavioral Testbench
-- Project Name: Template for Music Code Decoder for Homework 1
-- Created By: hso and jjwu
--
-- Copyright (C) 2023 Hayden So
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity symb_det is
    Port (  clk: in STD_LOGIC; -- input clock 96kHz
            clr: in STD_LOGIC; -- input synchronized reset
            adc_data: in STD_LOGIC_VECTOR(11 DOWNTO 0); -- input 12-bit ADC data
            
            symbol_valid: out STD_LOGIC;
            symbol_out: out STD_LOGIC_VECTOR(2 DOWNTO 0) -- output 3-bit detection symbol
            );
end symb_det;

architecture Behavioral of symb_det is
    
    signal previous_sample, current_sample : STD_LOGIC_VECTOR(11 DOWNTO 0) := "000000000000";
    signal zero_cross, sample_counter, clk_counter : integer := 0;
    signal test : integer := 0;

begin
    process(clr, clk)
    begin
        if clr = '1' then
                    symbol_valid <= '0';
                    zero_cross <= 0;
                    previous_sample <= "000000000000";
                    current_sample  <= "000000000000";
        
        elsif rising_edge(clk) then
                    symbol_valid <= '0';
                    clk_counter <= clk_counter +1;
                    sample_counter <= sample_counter +1;
                    
                    previous_sample <= current_sample;
                    current_sample <= adc_data;
                
                    if previous_sample >= "100000000000" and current_sample < "100000000000" then  -- at zero cross,, positive to negative
                        zero_cross <= zero_cross +1;
                        
                    end if;
                    
                    if clk_counter = 6000 then
                        symbol_valid <= '1';
                        clk_counter <= 0;
                    end if;
                    
                    if zero_cross = 1 then
                        sample_counter <= 0;
                    elsif (zero_cross = 2 ) then
                        
                        zero_cross <= 0;
                        
                        
                        
                        if sample_counter >=44 and sample_counter <= 47 then 
                            symbol_out <= "000";
                        elsif sample_counter >=53 and sample_counter <= 56 then 
                            symbol_out <= "001";
                        elsif sample_counter >=67 and sample_counter <= 70 then 
                            symbol_out <= "010";
                            --symbol_valid <= '1';
                        elsif sample_counter >=80 and sample_counter <= 83 then 
                            symbol_out <= "011";
                            --symbol_valid <= '1';
                        elsif sample_counter >=96 and sample_counter <= 99 then 
                            symbol_out <= "100";
                            --symbol_valid <= '1';
                        elsif sample_counter >=121 and sample_counter <= 124 then 
                            symbol_out <= "101";
                            --symbol_valid <= '1';
                        elsif sample_counter >=143 and sample_counter <= 146 then 
                            symbol_out <= "110";
                            --symbol_valid <= '1';
                        elsif sample_counter >=182 and sample_counter <= 185 then 
                            symbol_out <= "111";
                            --symbol_valid <= '1';
                        end if;
                   
                    end if;
        end if;
    end process;

end Behavioral;
