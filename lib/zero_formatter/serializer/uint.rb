module ZeroFormatter
  class Serializer
    module UInt8Serializer
      extend self
      Alias = %i(byte uint8 uint_8)

      def bytesize
        1
      end

      def serialize(value)
        Utils.write_u1(value)
      end

      def deserialize(bytes, offset=0, options={})
        Utils.read_u1(bytes, offset)
      end
    end

    module UInt16Serializer
      extend self
      Alias = %i(ushort uint16 uint_16)

      def bytesize
        2
      end

      def serialize(value)
        Utils.write_u2(value)
      end

      def deserialize(bytes, offset=0, options={})
        Utils.read_u2(bytes, offset)
      end
    end

    module UInt32Serializer
      extend self
      Alias = %i(uint uint32 uint_32)

      def bytesize
        4
      end

      def serialize(value)
        Utils.write_u4(value)
      end

      def deserialize(bytes, offset=0, options={})
        Utils.read_u4(bytes, offset)
      end
    end

    module UInt64Serializer
      extend self
      Alias = %i(ulong uint64 uint_64)

      def bytesize
        8
      end

      def serialize(value)
        Utils.write_u8(value)
      end

      def deserialize(bytes, offset=0, options={})
        Utils.read_u8(bytes, offset)
      end
    end
  end
end
