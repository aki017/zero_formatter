module ZeroFormatter
  module ZeroFormattable
    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def fields
        @fields || []
      end

      def field(name, type, options={})
        @fields ||= []
        index = options[:index] || @fields.size == 0 ? 0 : @fields.last[:index] + 1
        @fields << {
          index: index,
          name: name,
          type: type,
          options: options,
        }

        attr_accessor name
        return
      end
    end
  end
end
