module ZeroFormatter
  class Serializer
    module TimeSpanSerializer
      extend self
      Alias = %i(timespan duration)
      def serialize(value)
        value ||= { seconds: 0, nanos: 0 }
        Utils.write_s8(value[:seconds]) + Utils.write_s4(value[:nanos])
      end

      def deserialize(bytes, offset=0)
        value = {
          seconds: Utils.read_s8(bytes, offset),
          nanos: Utils.read_s4(bytes, offset+8)
        }
      end
    end

    module TimeSerializer
      extend self
      Alias = %i(datetime time)
      def serialize(value)
        value ||= Time.at(0)
        Utils.write_s8(value.to_i) << Utils.write_s4(value.nsec)
      end

      def deserialize(bytes, offset=0)
        value = Time.at(Utils.read_s8(bytes, offset), Utils.read_s4(bytes, offset+8)/1000.0)
      end
    end

    module TimeWithOffsetSerializer
      extend self
      Alias = %i(datetime_with_offset time_with_offset)
      def serialize(value)
        value ||= {time: Time.at(0), time_offset: 0}
        Utils.write_s8(value[:time].to_i + value[:time_offset]*60) << Utils.write_s4(value[:time].nsec) << Utils.write_s2(value[:time_offset])
      end

      def deserialize(bytes, offset=0)
        time = Time.at(Utils.read_s8(bytes, offset), Utils.read_s4(bytes, offset+8)/1000.0)
        time_offset = Utils.read_s2(bytes, offset+8+4)
        time -= time_offset*60
        {
          time: time,
          time_offset: time_offset
        }
      end
    end
  end
end
