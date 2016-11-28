module ZeroFormatter
  class Serializer
    module FloatSerializer
      extend self
      Alias = %i(single float)
      def serialize(value)
        Utils.write_f4(value)
      end

      def deserialize(bytes, offset=0, options={})
        Utils.read_f4(bytes, offset)
      end
    end

    module DoubleSerializer
      extend self
      Alias = %i(double)
      def serialize(value)
        Utils.write_d8(value)
      end

      def deserialize(bytes, offset=0, options={})
        Utils.read_d8(bytes, offset)
      end
    end
  end
end
