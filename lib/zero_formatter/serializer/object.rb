module ZeroFormatter
  class Serializer
    module ObjectSerializer
      extend self
      Alias = %i(object)
      def serialize(value)
        ZeroFormatter.dump(value)
      end

      def deserialize(bytes, offset=0, options={})
        object_size = Utils.read_s4(bytes, offset)
        raise "#{options[:type]} is not ZeroFormattable" unless options[:type].include? ZeroFormatter::ZeroFormattable
        ZeroFormatter.load(options[:type], bytes.byteslice(offset, object_size))
      end
    end
  end
end
