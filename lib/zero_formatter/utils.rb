module ZeroFormatter
  class Utils
    class << self
      def read_s1(bytes, index)
        to_signed(bytes.getbyte(index), 1 << (8 -1))
      end

      def read_u1(bytes, index)
        bytes.getbyte(index)
      end

      def read_u2(bytes, index)
        bytes.byteslice(index, 2).unpack('v')[0]
      end

      def read_s2(bytes, index)
        to_signed(read_u2(bytes, index), 1 << (16 - 1))
      end

      def read_u4(bytes, index)
        bytes.byteslice(index, 4).unpack('V')[0]
      end

      def read_s4(bytes, index)
        to_signed(read_u4(bytes, index), 1 << (32 - 1))
      end

      def read_u8(bytes, index)
        l, h = bytes.byteslice(index, 8).unpack('VV')
        (h << 32) + l
      end

      def read_s8(bytes, index)
        to_signed(read_u8(bytes, index), 1 << (64 - 1))
      end

      def read_f4(bytes, index)
        bytes.byteslice(index, 4).unpack('e')[0]
      end

      def read_d8(bytes, index)
        bytes.byteslice(index, 8).unpack('E')[0]
      end

      def to_signed(v, mask)
        (v & ~mask) - (v & mask)
      end




      def write_u1(value)
        value ||= 0
        [value].pack("C")
      end

      def write_s1(value)
        value ||= 0
        [value].pack("c")
      end

      def write_u2(value)
        value ||= 0
        [value].pack('v')
      end

      def write_s2(value)
        value ||= 0
        [value].pack('v')
      end

      def write_u4(value)
        value ||= 0
        [value].pack('V')
      end

      def write_s4(value)
        value ||= 0
        [value].pack('V')
      end

      def write_u8(value)
        value ||= 0
        [value].pack('Q!<')
      end

      def write_s8(value)
        value ||= 0
        value += (2 ** 64) if value < 0
        [value].pack('q!<')
      end

      def write_f4(value)
        value ||= 0.0
        [value].pack("e")
      end

      def write_d8(value)
        value ||= 0.0
        [value].pack("E")
      end
    end
  end
end
