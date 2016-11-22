require "./zeroformattable"

class DataClass
  include ZeroFormattable
  field :int16                  , type: :Int16
  field :int32                  , type: :Int32
  field :int64                  , type: :Int64
  field :uInt16                 , type: :UInt16
  field :uInt32                 , type: :UInt32
  field :uInt64                 , type: :UInt64
  field :single                 , type: :Single
  field :double                 , type: :Double
  field :boolean                , type: :Boolean
  field :byte                   , type: :Byte
  field :sByte                  , type: :SByte
  field :char                   , type: :Char
  field :timeSpan               , type: :TimeSpan
  field :dateTime               , type: :DateTime
  field :dateTimeOffset         , type: :DateTimeOffset
  field :string                 , type: :String
  field :int16Nullable          , type: :Int16,          nullable: true
  field :int32Nullable          , type: :Int32,          nullable: true
  field :int64Nullable          , type: :Int64,          nullable: true
  field :uInt16Nullable         , type: :UInt16,         nullable: true
  field :uInt32Nullable         , type: :UInt32,         nullable: true
  field :uInt64Nullable         , type: :UInt64,         nullable: true
  field :singleNullable         , type: :Single,         nullable: true
  field :doubleNullable         , type: :Double,         nullable: true
  field :booleanNullable        , type: :Boolean,        nullable: true
  field :byteNullable           , type: :Byte,           nullable: true
  field :sByteNullable          , type: :SByte,          nullable: true
  field :charNullable           , type: :Char,           nullable: true
  field :timeSpanNullable       , type: :TimeSpan,       nullable: true
  field :dateTimeNullable       , type: :DateTime,       nullable: true
  field :dateTimeOffsetNullable , type: :DateTimeOffset, nullable: true
end

orig = File.binread("cs/data.pack")
obj = DataClass.parse(orig)
n = obj.to_zeroformat
(0..orig.size).each do |i|
  if orig.getbyte(i) != n.getbyte(i)
    puts i.to_s(16)
  end
end
n.each_byte.with_index{|b, i| 
  print i.to_s(16).rjust(8, "0"), "|" if i%16 == 0
  print " "
  print b.to_s(16).rjust(2, "0")
  print " " if i%16 == 7
  puts if i%16 == 15
}
