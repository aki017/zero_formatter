require "zero_formatter/version"
require "zero_formatter/utils"
require "zero_formatter/serializer"
require "zero_formatter/zero_formattable"

module ZeroFormatter
  def self.load(klass, bytes)
    serializer.load(klass, bytes)
  end

  def self.dump(data)
    serializer.dump(data)
  end

  def self.serializer
    @serializer ||= Serializer.new
  end
end
