----------------------------------------------------------------------------------
-- Engineer: 
-- 
-- Create Date: 10.10.2023 21:35:55
-- Design Name: 
-- Module Name: mucodec - Behavioral
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

entity mucodec is
    Port ( din : in std_logic_vector(2 downto 0);
           valid : in std_logic;
           clr : in std_logic;
           clk : in std_logic;
           
           dout : out std_logic_vector(7 downto 0);
           dvalid : out std_logic;
           error : out std_logic  );
end mucodec;

architecture Behavioral of mucodec is
    type state_type is (initial, wait_71, wait_02, wait_72, wait_input, input_1, input_2, input_3, input_4, input_5, input_6, e_wait_01, e_wait_72, e_wait_02, fail);
    signal current_state, next_state: state_type;
begin
    
    sync_proc: process(clk, clr, din, valid)
    begin
        if clr = '1' then
            current_state <= initial;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    
    end process;
    
    next_state_decode: process(din, valid)
    begin
        case current_state is
            when initial =>
                if din = "000" then
                    next_state <= wait_71;
                    
                else
                    next_state <= fail;
                    
                end if;
                
            when wait_71 =>
                if din =  "111" then
                    next_state <= wait_02;
                    
                else
                    next_state <= fail;
                    
                end if;
                
            when wait_02 =>
                if din = "000" then
                    next_state <= wait_72;
                else
                    next_state <= fail;
                end if;
                
            when wait_72 => 
                if din = "111" then
                    next_state <= wait_input;
                else
                    next_state <= fail;
                end if;
                
            when wait_input =>   -- first digit
                
                case din is
                    when "001" => next_state <= input_1;
                    when "010" => next_state <= input_2;
                    when "011" => next_state <= input_3;
                    when "100" => next_state <= input_4;
                    when "101" => next_state <= input_5;
                    when "110" => next_state <= input_6;   
                        
                end case;
                
                if (din = "000" or din = "111") then
                        next_state <= fail;
                end if; 
                
            -- second digit--
            when input_1 =>    
                case din is
                    when "001" => dvalid <= '0';
                    when "010" => dout <= "01000010"; --B
                    when "011" => dout <= "01000100"; --D
                    when "100" => dout <= "01001000"; --H
                    when "101" => dout <= "01001100"; --L
                    when "110" => dout <= "01010010"; --R    
                
                end case;
                next_state <= wait_input;
                
                if din = "000" then 
                    next_state <= fail;
                elsif din = "111" then     -- if EOS?
                    next_state <= e_wait_01;
                end if;
                
            when input_2 =>
                case din is 
                    when "001" => dout <= "01000001"; --A
                    when "010" => dvalid <= '0';
                    when "011" => dout <= "01000111"; --G
                    when "100" => dout <= "01001011"; --K
                    when "101" => dout <= "01010001"; --Q
                    when "110" => dout <= "01010110"; --V
                    
                end case;
                
            when input_3 =>
                case din is
                    when "001" => dout <= "01000011"; --C
                    when "010" => dout <= "01000110"; --F
                    when "011" => dvalid <= '0';
                    when "100" => dout <= "01010000"; --P
                    when "101" => dout <= "01010101"; --U
                    when "110" => dout <= "01011010"; --Z
                end case;
                
            when input_4 =>
                case din is
                    when "001" => dout <= "01000101"; --E
                    when "010" => dout <= "01001010"; --J
                    when "011" => dout <= "01001111"; --O
                    when "100" => dvalid <= '0';
                    when "101" => dout <= "01011001"; --Y
                    when "110" => dout <= "00101110"; --.
                end case;
                
            when input_5 =>
                case din is
                    when "001" => dout <= "01001001"; --I
                    when "010" => dout <= "01001110"; --N
                    when "011" => dout <= "01010100"; --T
                    when "100" => dout <= "01011000"; --X
                    when "101" => dvalid <= '0';
                    when "110" => dout <= "00111111"; --?
                end case;
                
            when input_6 =>
                case din is
                    when "001" => dout <= "01001101"; --M
                    when "010" => dout <= "01010011"; --S
                    when "011" => dout <= "01010111"; --W
                    when "100" => dout <= "00100001"; --!
                    when "101" => dout <= "00100000"; --SPACE
                    when "110" => dvalid <= '0';
                end case;
            --second digit----
                
        end  case;
    end process;
    

end Behavioral;
