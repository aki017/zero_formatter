module ZeroFormatter
  class Serializer
    module CharSerializer
      extend self
      Alias = %i(char)
      def serialize(value)
        bytesize = (value || "").bytesize
        result = value || ""
        (result.encode("utf-16le").bytes + [0, 0]).pack("CC")
      end

      def deserialize(bytes, offset=0)
        bytes.byteslice(offset, 2).force_encoding("utf-16le").encode(__ENCODING__)
      end
    end

    module StringSerializer
      extend self
      Alias = %i(string str)
      def serialize(value)
        value ||= ""

        Utils.write_s4(value.bytesize) << value
      end

      def deserialize(bytes, offset=0)
        len = Utils.read_s4(bytes, offset)
        bytes.byteslice(offset+4, len)
      end
    end
  end
end
