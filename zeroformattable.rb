module ZeroFormattable
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def fields
      @fields
    end

    def field(name, options)
      @index ||= -1
      @index = options[:index] || @index+1
      # print @index, ": ", name
      # puts
      @fields ||= []
      @fields[@index] = { name: name, options: options }

      index = @index
      attr_writer name
      define_method(name) do
        value = instance_variable_get("@#{name}")
        return value unless value.nil?
        value = nil
        offset = read_s4(8+4*index)
        has_value = true
        if options[:nullable]
          has_value = read_byte(offset) == 1
          offset += 1
        end

        case options[:type]
        when :Int16
          value = read_s2(offset)
        when :Int32
          value = read_s4(offset)
        when :Int64
          value = read_s8(offset)
        when :UInt16
          value = read_u2(offset)
        when :UInt32
          value = read_u4(offset)
        when :UInt64
          value = read_u8(offset)
        when :Single
          value = read_f4(offset)
        when :Double
          value = read_d8(offset)
        when :Boolean
          byte = read_byte(offset)
          raise if byte != 0 && byte != 1
          value = byte == 1
        when :Byte
          value = read_byte(offset)
        when :SByte
          value = read_byte(offset)
        when :Char
          value = read_u2(offset)
        when :TimeSpan
          value = {
            seconds: read_s8(offset),
            nanos: read_s4(offset+8)
          }
        when :DateTime
          value = Time.at(read_s8(offset), read_s4(offset+8)/1000)
        when :DateTimeOffset
          value = Time.at(read_s8(offset), read_s4(offset+8)/1000)-read_s2(offset+8+4)*60
        when :String
          len = read_s4(offset)
          value = @bytes.byteslice(offset+4, len)
        end
        
        if has_value
          instance_variable_set("@#{name}", value)
          value
        else
          instance_variable_set("@#{name}", nil)
          nil
        end
      end
    end

    def parse(bytes)
      o = self.new
      o.instance_eval{ @bytes = bytes }
      o
    end
  end

  def read_u2(index)
    @bytes.byteslice(index, 2).unpack('v')[0]
  end

  def read_s2(index)
    to_signed(read_u2(index), 1 << (16 - 1))
  end

  def read_u4(index)
    @bytes.byteslice(index, 4).unpack('V')[0]
  end

  def read_s4(index)
    to_signed(read_u4(index), 1 << (32 - 1))
  end

  def read_u8(index)
    l, h = @bytes.byteslice(index, 8).unpack('VV')
    (h << 32) + l
  end

  def read_s8(index)
    to_signed(read_u8(index), 1 << (64 - 1))
  end

  def read_f4(index)
    @bytes.byteslice(index, 4).unpack('e')[0]
  end

  def read_d8(index)
    @bytes.byteslice(index, 8).unpack('E')[0]
  end

  def read_byte(index)
    @bytes.getbyte(index)
  end

  def to_signed(v, mask)
    (v & ~mask) - (v & mask)
  end

  def to_zeroformat
    field_info = []
    field_data = ""
    self.class.fields.each do |f|
      field_info << field_data.size
      value = send(f[:name])
      if f[:options][:nullable]
        if value.nil?
          field_data << [0].pack("C")
        else
          field_data << [1].pack("C")
        end
      end
      field_data << case f[:options][:type]
      when :Int16
        value ||= 0
        [value].pack("v")
      when :Int32
        value ||= 0
        [value].pack("V")
      when :Int64
        value ||= 0
        [value % (1 <<32), value >> 32].pack("VV")
      when :UInt16
        value ||= 0
        [value].pack("v")
      when :UInt32
        value ||= 0
        [value].pack("V")
      when :UInt64
        value ||= 0
        [value % (1 <<32), value >> 32].pack("VV")
      when :Single
        value ||= 0.0
        [value].pack("e")
      when :Double
        value ||= 0.0
        [value].pack("E")
      when :Boolean
        value ||= false
        [(value ? 1 : 0)].pack("C")
      when :Byte
        value ||= 0
        [value].pack("C")
      when :SByte
        value ||= 0
        [value].pack("C")
      when :Char
        value ||= 0
        [value].pack("v")
      when :TimeSpan
        value ||= { seconds: 0, nanos: 0 }
        [value[:seconds].to_i % (1 <<32), value[:seconds].to_i >> 32, value[:nanos]].pack("V2V")
      when :DateTime
        value ||= Time.at(0)
        [value.to_i % (1 <<32), value.to_i >> 32, value.usec*1000].pack("V2V")
      when :DateTimeOffset
        value_offset = value.nil? ? 0 : 60*9 
        value ||= Time.at(0)
        value += value_offset * 60
        [value.to_i % (1 <<32), value.to_i >> 32, value.usec*1000, value_offset].pack("V2Vv")
      when :String
        value ||= ""
        [value.bytesize].pack("V") + value
      else
        0xff
      end
    end


    size = 4+4+4*field_info.size+field_data.size
    offset = 4+4+4*field_info.size 
    [size, self.class.fields.size-1].pack("VV") + field_info.map{|v| v+offset}.pack("V*") + field_data
  end
end
