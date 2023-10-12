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
           dvalid : out std_logic := '0';
           error : out std_logic := '0');
end mucodec;

architecture Behavioral of mucodec is
    type state_type is (initial, wait_71, wait_02, wait_72, wait_input, input_1, input_2, input_3, input_4, input_5, input_6, e_wait_01, e_wait_72, e_wait_02, fail);
    signal current_state, next_state: state_type;
begin
    
    sync_proc: process(clk, clr, valid)
    begin
        if clr = '1' then
            current_state <= initial;
        elsif (rising_edge(clk))then
            current_state <= next_state;
        end if;
    
    end process;
    
    next_state_decode: process(clk, din, valid)
    begin
        if (valid = '1' and rising_edge(clk)) then
        
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
                    dvalid <= '0';
                    case din is
                        when "001" => next_state <= input_1;
                        when "010" => next_state <= input_2;
                        when "011" => next_state <= input_3;
                        when "100" => next_state <= input_4;
                        when "101" => next_state <= input_5;
                        when "110" => next_state <= input_6;  
                        
                        when "000" => next_state <= fail;
                        when "111" => next_state <= e_wait_01;
                        when others => 
                            next_state <= fail;
                            error <= '1';
                            
                    end case;
                    
                -- second digit--
                when input_1 =>    
                    case din is
                        when "001" => dvalid <= '0';
                        when "010" => dout <= "01000010"; --B
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "011" => dout <= "01000100"; --D
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "100" => dout <= "01001000"; --H
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "101" => dout <= "01001100"; --L
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "110" => dout <= "01010010"; --R 
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        
                        when "000" => next_state <= fail;
                        when "111" => next_state <= fail;
                        when others => next_state <= fail;  
                    
                    end case;
                    
                when input_2 =>
                    case din is 
                        when "001" => dout <= "01000001"; --A
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "010" => dvalid <= '0';
                        when "011" => dout <= "01000111"; --G
                                      dvalid <= '1';
                                      next_state <= wait_input;next_state <= wait_input;
                        when "100" => dout <= "01001011"; --K
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "101" => dout <= "01010001"; --Q
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "110" => dout <= "01010110"; --V
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        
                        when "000" => next_state <= fail;
                        when "111" => next_state <= fail;
                        when others => next_state <= fail;
                        
                    end case;
                    
                when input_3 =>
                    case din is
                        when "001" => dout <= "01000011"; --C
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "010" => dout <= "01000110"; --F
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "011" => dvalid <= '0';
                                      next_state <= wait_input;
                        when "100" => dout <= "01010000"; --P
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "101" => dout <= "01010101"; --U
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "110" => dout <= "01011010"; --Z
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        
                        when "000" => next_state <= fail;
                        when "111" => next_state <= fail;
                        when others => next_state <= fail;
                            
                    end case;
                    
                when input_4 =>
                    case din is
                        when "001" => dout <= "01000101"; --E
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "010" => dout <= "01001010"; --J
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "011" => dout <= "01001111"; --O
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "100" => dvalid <= '0';
                                      next_state <= wait_input;
                        when "101" => dout <= "01011001"; --Y
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "110" => dout <= "00101110"; --.
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        
                        when "000" => next_state <= fail;
                        when "111" => next_state <= fail;
                        when others => next_state <= fail;
                            
                    end case;
                    
                when input_5 =>
                    case din is
                        when "001" => dout <= "01001001"; --I
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "010" => dout <= "01001110"; --N
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "011" => dout <= "01010100"; --T
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "100" => dout <= "01011000"; --X
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "101" => dvalid <= '0';
                                      next_state <= wait_input;
                        when "110" => dout <= "00111111"; --?
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        
                        when "000" => next_state <= fail;
                        when "111" => next_state <= fail;
                        when others => next_state <= fail;
                            
                    end case;
                    
                when input_6 =>
                    case din is
                        when "001" => dout <= "01001101"; --M
                                      dvalid <= '1';
                                      next_state <= wait_input;next_state <= wait_input;
                        when "010" => dout <= "01010011"; --S
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "011" => dout <= "01010111"; --W
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "100" => dout <= "00100001"; --!
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "101" => dout <= "00100000"; --SPACE
                                      dvalid <= '1';
                                      next_state <= wait_input;
                        when "110" => dvalid <= '0';
                                      next_state <= wait_input;
                        
                        when "000" => next_state <= fail;
                        when "111" => next_state <= fail;
                        when others => next_state <= fail;
                            
                    end case;
                    
                --second digit----
                
                when e_wait_01 =>
                    dvalid <= '0';
                    if din = "000" then
                        next_state <= e_wait_72;
                    else
                        next_state <= fail;
                    end if;
                    
                when e_wait_72 =>
                    if din = "111" then
                        next_state <= e_wait_02;
                    else
                        next_state <= fail; 
                    end if;
                    
                when e_wait_02 =>
                    if din = "000" then
                        next_state <= initial;
                        
                    else
                        next_state <= fail;
                    end if;
                    
                when fail =>
                    dvalid <= '0';
                    if din = "000" then
                        next_state <= wait_71;
                    else
                        next_state <= fail;
                    end if;
                    
            end  case;
        elsif (valid = '0' and rising_edge(clk)) Then dvalid <= '0';
        end if;
        
    end process;
    
    output_proc: process(current_state)
    begin
        if current_state = fail then    --error
            error <= '1';
        else
            error <= '0';
        end if;
        
    end process;
    

end Behavioral;
