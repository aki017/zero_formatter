module ZeroFormatter
  class Serializer
    module BoolSerializer
      extend self
      Alias = %i(bool boolean)

      def bytesize
        1
      end

      def serialize(value)
        Utils.write_u1(value ? 1 : 0)
      end

      def deserialize(bytes, offset=0, options={})
        Utils.read_u1(bytes, offset)==1
      end
    end
  end
end
