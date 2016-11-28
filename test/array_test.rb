require 'test_helper'

class RecursiveTest < Minitest::Test
  def test_fixed
    value = FixedDataClass.new
    value.values = [1,2,3,4,5]

    bytes = ZeroFormatter.dump(value)
    assert_equal bytes.bytes, ZeroFormatter.dump(ZeroFormatter.load(FixedDataClass, bytes)).bytes
    assert_equal [1,2,3,4,5], ZeroFormatter.load(FixedDataClass, bytes).values
  end

  def test_variable
    value = VariableDataClass.new
    value.messages = ["hello", "world"]

    bytes = ZeroFormatter.dump(value)
    assert_equal ["hello", "world"], ZeroFormatter.load(VariableDataClass, bytes).messages
    assert_equal bytes.bytes, ZeroFormatter.dump(ZeroFormatter.load(VariableDataClass, bytes)).bytes
  end

  class FixedDataClass
    include ZeroFormatter::ZeroFormattable
    field :values, :int, array: true
  end
  class VariableDataClass
    include ZeroFormatter::ZeroFormattable
    field :messages, :string, array: true
  end
end
