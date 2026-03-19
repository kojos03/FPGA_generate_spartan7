-- sigmoid_lut.vhd  (Vivado + ISE friendly; no black box)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sigmoid_lut is
  port (
    clka  : in  std_logic;
    ena   : in  std_logic;
    addra : in  std_logic_vector(11 downto 0);   -- 0..4095
    douta : out std_logic_vector(7 downto 0)     -- 0..255
  );
end entity;

architecture rtl of sigmoid_lut is
  signal dout_r       : std_logic_vector(7 downto 0) := (others => '0');

  -- Deeply pipelined approximation stages to reduce the critical path.
  signal s1_u_q15     : integer := 0;
  signal s2_u_q15     : integer := 0;
  signal s2_u_sq_q15  : integer := 0;
  signal s3_u_q15     : integer := 0;
  signal s3_u_cu_q15  : integer := 0;
  signal s4_y_q15     : integer := 0;
  signal s5_y255      : integer := 0;

  -- saturate integer to 0..255
  function sat8(x : integer) return std_logic_vector is
  begin
    if x < 0 then
      return std_logic_vector(to_unsigned(0, 8));
    elsif x > 255 then
      return std_logic_vector(to_unsigned(255, 8));
    else
      return std_logic_vector(to_unsigned(x, 8));
    end if;
  end function;
begin

  process(clka)
    variable addr_i : integer;
  begin
    if rising_edge(clka) then
      if ena = '1' then
        -- Stage 1: normalize address to Q1.15 domain around zero.
        addr_i   := to_integer(unsigned(addra));
        s1_u_q15 <= (addr_i - 2048) * 16;

        -- Stage 2: square term.
        s2_u_q15    <= s1_u_q15;
        s2_u_sq_q15 <= (s1_u_q15 * s1_u_q15) / 32768;

        -- Stage 3: cubic term.
        s3_u_q15    <= s2_u_q15;
        s3_u_cu_q15 <= (s2_u_sq_q15 * s2_u_q15) / 32768;

        -- Stage 4: polynomial in Q1.15
        -- y ~= 0.5 + 0.75*u - 0.25*u^3
        s4_y_q15 <= 16384
                    + ((24576 * s3_u_q15) / 32768)
                    - ((8192  * s3_u_cu_q15) / 32768);

        -- Stage 5: scale to 0..255
        s5_y255 <= (s4_y_q15 * 255 + 16384) / 32768;

        -- Stage 6: saturated output register
        dout_r <= sat8(s5_y255);
      else
        -- hold last value when disabled
        dout_r <= dout_r;
      end if;
    end if;
  end process;

  douta <= dout_r;
end architecture;
