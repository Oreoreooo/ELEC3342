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
            adc_data: in std_logic_vector(11 DOWNTO 0); -- input 12-bit ADC data
            symbol_valid: out STD_LOGIC:= '0';
            symbol_out: out STD_LOGIC_VECTOR(2 DOWNTO 0):= "000" -- output 3-bit detection symbol
            );
end symb_det;

architecture Behavioral of symb_det is
    
    signal previous_sample, current_sample : std_logic_vector(11 DOWNTO 0) := "000000000000";
    signal zero_cross, sample_counter, clk_counter : integer := 0;

begin
    process(clr, clk)
    begin
        if (clr = '1') then
                    symbol_valid <= '0';
                    zero_cross <= 0;
                    previous_sample <= "000000000000";
                    current_sample  <= "000000000000";
        end if;
        if (rising_edge(clk) and clr = '0') then
                    
                    previous_sample <= current_sample;
                    current_sample <= adc_data;

                    IF (previous_sample(11) = '0') THEN
                          IF (adc_data(11) = '1') THEN
                              zero_cross <= zero_cross +1;
                          END IF;
                    END IF;
                    IF (previous_sample(11) = '1') THEN
                          IF (adc_data(11) = '0') THEN
                              zero_cross <= zero_cross +1;
                          END IF;
                    END IF;
                    
                    IF (clk_counter = 6000) THEN
                        clk_counter <= 0;
                        symbol_valid <= '1';
                        if (zero_cross > 0) then
                            if zero_cross >=254 and zero_cross <= 269 then 
                                symbol_out <= "000";
                            elsif zero_cross >=213 and zero_cross <= 227 then 
                                symbol_out <= "001";
                            elsif zero_cross >=167 and zero_cross <= 183 then 
                                symbol_out <= "010";
                                --symbol_valid <= '1';
                            elsif zero_cross >=139 and zero_cross <= 154 then 
                                symbol_out <= "011";
                                --symbol_valid <= '1';
                            elsif zero_cross >=118 and zero_cross <= 131 then 
                                symbol_out <= "100";
                                --symbol_valid <= '1';
                            elsif zero_cross >=91 and zero_cross <= 105 then 
                                symbol_out <= "101";
                                --symbol_valid <= '1';
                            elsif zero_cross >=75 and zero_cross <= 90 then 
                                symbol_out <= "110";
                                --symbol_valid <= '1';
                            elsif zero_cross >=58 and zero_cross <= 73 then 
                                symbol_out <= "111";
                                --symbol_valid <= '1';
                            end if;
                                                    
                            zero_cross <= 0;
                        end if;
                    else
                        clk_counter <= clk_counter + 1;
                        symbol_valid <= '0';
                    end if;
                    
                   
        end if;
    end process;

end Behavioral;
