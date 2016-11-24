module ZeroFormatter
  module Serializer
    class ObjectSerializer
      def initialize(klass)
        @klass = klass
      end

      def serialize(value)
        ZeroFormatter.dump(klass, bytes)
      end

      def deserialize(bytes)
        ZeroFormatter.parse(klass, bytes)
        object_size = read_s4(bytes, 0)
        raise "Object size missmatch, expected=#{object_size}, actual=#{bytes.bytesize}" if object_size != bytes.bytesize

        field_num = read_s4(bytes, 4)
        raise "Field count is negative, #{field_num}" if field_num < 0

        field_map = 
      end
    end
  end
end
