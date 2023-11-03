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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myuart is
    Port ( 
           din : in STD_LOGIC_VECTOR (7 downto 0);
           busy: out STD_LOGIC;
           wen : in STD_LOGIC;
           sout : out STD_LOGIC;
           clr : in STD_LOGIC;
           clk : in STD_LOGIC);
end myuart;

architecture rtl of myuart is
type state_type is (Idle, Start, D0,D1,D2,D3,D4,D5,D6,D7,Stop);
signal state, next_state: state_type;
signal cnt: unsigned(4 downto 0);
                                              

begin
    process (clk,clr)
    begin
        if clr = '1' then
            state <= Idle;
            --busy <= '0';
            --sout <= '1';
        elsif rising_edge(clk) then 
            state <= next_state;
        end if;
    end process;
    
    process(wen,state, cnt)
    begin
        case state is 
            when Idle =>
                busy <= '0';
                sout <= '1';
                if wen = '1' then
                    next_state <= Start;
                    cnt <= (others => '0');
                    
                end if;
           when Start =>
                busy <= '1';
                sout <= '0';
                if cnt  <= "1010" then
                   cnt <=(others => '0');
                   next_state <= D0;
                else
                  cnt <= cnt + 1;
                end if;
           when D0 =>
                busy <='1';
                sout <= din(0);
                if cnt <= "1010" then
                    cnt <= (others => '0');
                    next_state <= D1;
                else
                    cnt <= cnt + 1;
                end if;
          when D1 =>
                busy <= '1';
                sout <= din(1);
                if cnt <= "1010" then
                    cnt <=(others => '0');
                    next_state <= D2;
                else 
                    cnt <= cnt + 1;
                end if;
         when D2 =>
               busy <= '1';
               sout <= din(2);
               if cnt <= "1010" then
                   cnt <= (others => '0');
                   next_state <= D3;
               else 
                   cnt <= cnt + 1;
               end if;
         when D3 =>
              busy <= '1';
              sout <= din(3);
              if cnt <= "1010" then
                cnt <= (others => '0');
                next_state <= D4 ;
              else 
                cnt <= cnt + 1;
              end if;
         when D4 =>
              busy <= '1';
              sout <= din(4);
              if cnt <= "1010" then
                cnt <= (others => '0');
                next_state <= D5;
              else
                cnt <= cnt + 1;
             end if;
         when D5 =>
              busy <= '1';
              sout <= din(5);
              if cnt <= "1010" then
                cnt <= (others => '0');
                next_state <= D6;
              else 
                cnt <= cnt + 1;
              end if;
         when D6 =>
              busy <= '1';
              sout <= din(6);
              if cnt <= "1010" then
                cnt <= (others => '0');
                next_state <= D7;
              else
                cnt <= cnt + 1;
              end if;
         when D7 =>
              busy <= '1';
              sout <= din(7);
              if cnt <= "1010" then
                cnt <= (others => '0');
                next_state <= Stop;
             else
                cnt <= cnt + 1;
             end if;
         when Stop =>
             sout <= '1';
             if cnt <= "1010" then
                cnt <= (others => '0');
                next_state <= Idle;
            else 
                cnt <= cnt + 1;
            end if;
        end case;
    end process;                                        
                                    
                                      
                             
                           
end rtl;
