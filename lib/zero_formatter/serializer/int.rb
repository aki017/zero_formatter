module ZeroFormatter
  class Serializer
    module Int8Serializer
      extend self
      Alias = %i(sbyte int8 int_8)

      def bytesize
        1
      end

      def serialize(value)
        Utils.write_s1(value)
      end

      def deserialize(bytes, offset=0, options={})
        Utils.read_s1(bytes, offset)
      end
    end

    module Int16Serializer
      extend self
      Alias = %i(short int16 int_16)

      def bytesize
        2
      end

      def serialize(value)
        Utils.write_s2(value)
      end

      def deserialize(bytes, offset=0, options={})
        Utils.read_s2(bytes, offset)
      end
    end

    module Int32Serializer
      extend self
      Alias = %i(int int32 int_32)

      def bytesize
        4
      end

      def serialize(value)
        Utils.write_s4(value)
      end

      def deserialize(bytes, offset=0, options={})
        Utils.read_s4(bytes, offset)
      end
    end

    module Int64Serializer
      extend self
      Alias = %i(long int64 int_64)

      def bytesize
        8
      end

      def serialize(value)
        Utils.write_s8(value)
      end

      def deserialize(bytes, offset=0, options={})
        Utils.read_s8(bytes, offset)
      end
    end
  end
end
