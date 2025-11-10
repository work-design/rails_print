module Crc16Util
  extend self
  POLY  = 0x1021
  INIT  = 0xFFFF
  XOROUT = 0xFFFF

  # 单字节位反射
  def reflect8(b)
    b = (b & 0xF0) >> 4 | (b & 0x0F) << 4
    b = (b & 0xCC) >> 2 | (b & 0x33) << 2
    b = (b & 0xAA) >> 1 | (b & 0x55) << 1
    b
  end

  # 16 位反射
  def reflect16(w)
    w = (w & 0xFF00) >> 8 | (w & 0x00FF) << 8
    w = (w & 0xF0F0) >> 4 | (w & 0x0F0F) << 4
    w = (w & 0xCCCC) >> 2 | (w & 0x3333) << 2
    w = (w & 0xAAAA) >> 1 | (w & 0x5555) << 1
    w
  end

  # CRC-16/X25 主入口
  def check(data_hex_string)
    crc = INIT
    # 按空格拆分 16 进制字节
    data_hex_string.each do |hex|
      byte = reflect8(hex.to_i(16))
      crc ^= byte << 8
      8.times do
        crc = (crc & 0x8000) != 0 ? (crc << 1) ^ POLY : crc << 1
      end
      crc &= 0xFFFF
    end
    # 输出反射 + 最终异或
    reflect16(crc) ^ XOROUT
  end
end
