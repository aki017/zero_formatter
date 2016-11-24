module ZeroFormatter
  class Serializer
    module BoolSerializer
      extend self
      Alias = %i(bool boolean)
      def serialize(value)
        Utils.write_byte(value ? 1 : 0)
      end

      def deserialize(bytes, offset=0)
        Utils.read_byte(bytes, offset)==1
      end
    end
  end
end
