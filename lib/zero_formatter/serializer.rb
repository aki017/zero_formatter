require "zero_formatter/serializer/int"
require "zero_formatter/serializer/uint"
require "zero_formatter/serializer/fp"
require "zero_formatter/serializer/bool"
require "zero_formatter/serializer/string"
require "zero_formatter/serializer/time"
require "zero_formatter/serializer/object"

module ZeroFormatter
  class Serializer
    def initialize(*args)
      add_implement Int8Serializer
      add_implement Int16Serializer
      add_implement Int32Serializer
      add_implement Int64Serializer

      add_implement UInt8Serializer
      add_implement UInt16Serializer
      add_implement UInt32Serializer
      add_implement UInt64Serializer

      add_implement FloatSerializer
      add_implement DoubleSerializer

      add_implement BoolSerializer

      add_implement CharSerializer
      add_implement StringSerializer

      add_implement TimeSpanSerializer
      add_implement TimeSerializer
      add_implement TimeWithOffsetSerializer

      add_implement ObjectSerializer
    end

    def dump(value)
      last_index = value.class.fields.last[:index]

      data_headers = []
      data_header = "".force_encoding("ASCII-8bit")
      data = "".force_encoding("ASCII-8bit")
      header_size = 4 + 4 + (last_index+1)*4
      
      value.class.fields.each do |field|
        data_headers[field[:index]] = header_size + data.bytesize

        v = value.send(field[:name])

        if field[:options][:nullable]
          # nullable
          #
          # [hasValue:bool(1)]
          # [T]
          #
          data << Utils.write_u1(v.nil? ? 0 : 1)
        end

        if field[:options][:array]
          serializer = get_serializer(field[:type])
          bytesize = serializer.bytesize

          if bytesize >= 0
            # fixed-length format
            #
            #	[length:int(4)]
            #	[elements:T...]
            #
            if v.nil?
              data << Utils.write_s4(-1)
              next
            end

            data << Utils.write_s4(v.size)

            v.each do |vv|
              data << serializer.serialize(vv)
            end
          else
            # variable-length format
            #
            # [byteSize:int(4)]
            # [length:int(4)]
            # [elementOffset...:int(4 * length)]
            # [elements:T...]
            #
            offsets = ""
            elements = ""
            
            if v.nil?
              bytesize = 8
              length = -1
            else
              length = v.size
              v.each do |vv|
                offsets << Utils.write_s4(8+v.size*4+elements.size)
                elements << get_serializer(field[:type]).serialize(vv)
              end
            end
            data << Utils.write_s4(8+offsets.bytesize+elements.bytesize)
            data << Utils.write_s4(length)
            data << offsets
            data << elements
          end
        else
          data << get_serializer(field[:type]).serialize(v)
        end
      end

      data_headers.each do |h|
        data_header << Utils.write_s4(h || -1)
      end

      data_size = header_size + data.bytesize

      response = "".force_encoding("ASCII-8bit")
      response << Utils.write_s4(data_size)
      response << Utils.write_s4(last_index)
      response << data_header
      response << data
      response
    end

    def load(klass, bytes)
      object_size = Utils.read_s4(bytes, 0)
      raise "Object size missmatch, expected=#{object_size}, actual=#{bytes.bytesize}" if object_size != bytes.bytesize

      last_index = Utils.read_s4(bytes, 4)
      raise "Last index is negative, #{last_index}" if last_index < 0
      raise "Last index is bigger, expected=#{klass.fields.last[:index]}, actual=#{last_index}" if klass.fields.last[:index] < last_index

      result = klass.new

      klass.fields.each do |field|
        index = field[:index]
        offset = Utils.read_s4(bytes, 8+4*index)

        if field[:options][:nullable]
          # nullable
          #
          # [hasValue:bool(1)]
          # [T]
          #
          if Utils.read_u1(bytes, offset) == 0
            result.send("#{field[:name]}=", nil)
            next
          end
          offset += 1
        end

        if field[:options][:array]
          serializer = get_serializer(field[:type])
          bytesize = serializer.bytesize

          if bytesize >= 0
            # fixed-length format
            #
            #	[length:int(4)]
            #	[elements:T...]
            #
            obj_count = Utils.read_s4(bytes, offset)
            if obj_count == -1
              value = nil
            else
              value = (0..(obj_count-1)).map{|i|
                serializer.deserialize(bytes, offset+4+i*bytesize, field)
              }
            end
          else
            # variable-length format
            #
            # [byteSize:int(4)]
            # [length:int(4)]
            # [elementOffset...:int(4 * length)]
            # [elements:T...]
            #
            elements_length = Utils.read_s4(bytes, offset + 4)

            if elements_length == -1
              value = nil
            else
              elements_offsets = elements_length.times.map{|i| Utils.read_s4(bytes, offset + 8 + 4 * i)}
              value = elements_offsets.map{|o| serializer.deserialize(bytes, offset+o) }
            end
          end
        else
          value = get_serializer(field[:type]).deserialize(bytes, offset, field)
        end
        
        result.send("#{field[:name]}=", value)
      end
      result
    end

    private
    def add_implement(klass)
      @implements ||= []
      @implements << klass
      gen_type_table
    end

    def get_serializer(type)
      if @type_table[type]
        return @type_table[type]
      end

      if type.include? ZeroFormattable
        return @type_table[:object]
      end

      raise "Unknown type: #{type}"
    end

    def gen_type_table
      @type_table = Hash[@implements.flat_map{|klass|
        klass::Alias.map{|a| [a, klass]}
      }]
    end
  end
end
