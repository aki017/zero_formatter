require 'test_helper'

class ZeroFormatterTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ZeroFormatter::VERSION
  end

  def test_can_load
    value = ZeroFormatter.load(DataClass, fixture("data.pack"))
    refute_nil value

    assert_equal -16,    value.int16,   "value.int16"
    assert_equal -32,    value.int32,   "value.int32"
    assert_equal -64,    value.int64,   "value.int64"
    assert_equal 16,     value.uInt16,  "value.uInt16"
    assert_equal 32,     value.uInt32,  "value.uInt32"
    assert_equal 64,     value.uInt64,  "value.uInt64"
    assert_equal 1.0,    value.single,  "value.single"
    assert_equal 3.1415, value.double,  "value.double"
    assert_equal true,   value.boolean, "value.boolean"
    assert_equal 128,    value.byte,    "value.byte"
    assert_equal 127,    value.sByte,   "value.sByte"
    assert_equal 'a',    value.char,    "value.char"
    assert_equal ({seconds:1,nanos:0}), value.timeSpan, "value.timeSpan"
    assert_equal Time.at(1479804248, 206984), value.dateTime, "value.dateTime"
    assert_equal ({time:Time.at(1479804248, 213302),time_offset:9*60}), value.dateTimeOffset, "value.dateTimeOffset"
    assert_equal "TestString", value.string, "value.string"
    assert_equal nil, value.int16Nullable,          "value.int16Nullable"
    assert_equal nil, value.int32Nullable,          "value.int32Nullable"
    assert_equal nil, value.int64Nullable,          "value.int64Nullable"
    assert_equal nil, value.uInt16Nullable,         "value.uInt16Nullable"
    assert_equal nil, value.uInt32Nullable,         "value.uInt32Nullable"
    assert_equal nil, value.uInt64Nullable,         "value.uInt64Nullable"
    assert_equal nil, value.singleNullable,         "value.singleNullable"
    assert_equal nil, value.doubleNullable,         "value.doubleNullable"
    assert_equal nil, value.booleanNullable,        "value.booleanNullable"
    assert_equal nil, value.byteNullable,           "value.byteNullable"
    assert_equal nil, value.sByteNullable,          "value.sByteNullable"
    assert_equal nil, value.charNullable,           "value.charNullable"
    assert_equal nil, value.timeSpanNullable,       "value.timeSpanNullable"
    assert_equal nil, value.dateTimeNullable,       "value.dateTimeNullable"
    assert_equal nil, value.dateTimeOffsetNullable, "value.dateTimeOffsetNullable"
  end

  def test_can_dump
    value = DataClass.new
    value.int16                   = -16                        
    value.int32                   = -32                        
    value.int64                   = -64                        
    value.uInt16                  = 16                         
    value.uInt32                  = 32                         
    value.uInt64                  = 64                         
    value.single                  = 1.0                        
    value.double                  = 3.1415                     
    value.boolean                 = true                       
    value.byte                    = 128                        
    value.sByte                   = 127                        
    value.char                    = "a"
    value.timeSpan                = ({seconds:1,nanos:0})      
    value.dateTime                = Time.at(1479804248, 206984)
    value.dateTimeOffset          = ({time:Time.at(1479804248, 213302),time_offset:9*60})
    value.string                  = "TestString"               
    value.int16Nullable           = nil                        
    value.int32Nullable           = nil                        
    value.int64Nullable           = nil                        
    value.uInt16Nullable          = nil                        
    value.uInt32Nullable          = nil                        
    value.uInt64Nullable          = nil                        
    value.singleNullable          = nil                        
    value.doubleNullable          = nil                        
    value.booleanNullable         = nil                        
    value.byteNullable            = nil                        
    value.sByteNullable           = nil                        
    value.charNullable            = nil                        
    value.timeSpanNullable        = nil                        
    value.dateTimeNullable        = nil                        
    value.dateTimeOffsetNullable  = nil                        

    f = fixture("data.pack")
    a = ZeroFormatter.dump(value)

    assert_equal(f.bytes, a.bytes)
  end

  class DataClass
    include ZeroFormatter::ZeroFormattable
    field :int16,                  :int16
    field :int32,                  :int32
    field :int64,                  :int64
    field :uInt16,                 :uint16
    field :uInt32,                 :uint32
    field :uInt64,                 :uint64
    field :single,                 :float
    field :double,                 :double
    field :boolean,                :bool
    field :byte,                   :byte
    field :sByte,                  :sbyte
    field :char,                   :char
    field :timeSpan,               :timespan
    field :dateTime,               :datetime
    field :dateTimeOffset,         :datetime_with_offset
    field :string,                 :string
    field :int16Nullable,          :int16,                nullable: true
    field :int32Nullable,          :int32,                nullable: true
    field :int64Nullable,          :int64,                nullable: true
    field :uInt16Nullable,         :uint16,               nullable: true
    field :uInt32Nullable,         :uint32,               nullable: true
    field :uInt64Nullable,         :uint64,               nullable: true
    field :singleNullable,         :float,                nullable: true
    field :doubleNullable,         :double,               nullable: true
    field :booleanNullable,        :boolean,              nullable: true
    field :byteNullable,           :byte,                 nullable: true
    field :sByteNullable,          :sbyte,                nullable: true
    field :charNullable,           :char,                 nullable: true
    field :timeSpanNullable,       :timespan,             nullable: true
    field :dateTimeNullable,       :datetime,             nullable: true
    field :dateTimeOffsetNullable, :datetime_with_offset, nullable: true
  end
end
