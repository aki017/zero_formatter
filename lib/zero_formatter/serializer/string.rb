module ZeroFormatter
  class Serializer
    module CharSerializer
      extend self
      Alias = %i(char)
      def serialize(value)
        bytesize = (value || "").bytesize
        result = value || ""
        result = result.dup
        (2-bytesize).times{ result << 0 }
        result
      end

      def deserialize(bytes, offset=0)
        is_multibyte = Utils.read_byte(bytes, offset+1) != 0
        bytes.byteslice(offset, is_multibyte ? 2 : 1).force_encoding("utf-8")
      end
    end

    module StringSerializer
      extend self
      Alias = %i(string str)
      def serialize(value)
        Utils.write_s4(value.bytesize) << value
      end

      def deserialize(bytes, offset=0)
        len = Utils.read_s4(bytes, offset)
        bytes.byteslice(offset+4, len)
      end
    end
  end
end
