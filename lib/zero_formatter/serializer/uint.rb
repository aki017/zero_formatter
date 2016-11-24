module ZeroFormatter
  class Serializer
    module UInt8Serializer
      extend self
      Alias = %i(byte uint8 uint_8)
      def serialize(value)
        Utils.write_byte(value)
      end

      def deserialize(bytes, offset=0)
        Utils.read_byte(bytes, offset)
      end
    end

    module UInt16Serializer
      extend self
      Alias = %i(ushort uint16 uint_16)
      def serialize(value)
        Utils.write_s2(value)
      end

      def deserialize(bytes, offset=0)
        Utils.read_s2(bytes, offset)
      end
    end

    module UInt32Serializer
      extend self
      Alias = %i(uint uint32 uint_32)
      def serialize(value)
        Utils.write_s4(value)
      end

      def deserialize(bytes, offset=0)
        Utils.read_s4(bytes, offset)
      end
    end

    module UInt64Serializer
      extend self
      Alias = %i(ulong uint64 uint_64)
      def serialize(value)
        Utils.write_s8(value)
      end

      def deserialize(bytes, offset=0)
        Utils.read_s8(bytes, offset)
      end
    end
  end
end
