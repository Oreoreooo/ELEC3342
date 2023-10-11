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

begin


end Behavioral;
