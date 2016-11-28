require 'test_helper'

class RecursiveTest < Minitest::Test
  def test_can_load
    value = DataClass.new
    value.child = DataClassChild.new
    value.child.message = "Child"
    bytes = ZeroFormatter.dump(value)
    assert_equal bytes, ZeroFormatter.dump(ZeroFormatter.load(DataClass, bytes))
    assert_equal "Child", ZeroFormatter.load(DataClass, bytes).child.message
  end

  class DataClassChild
    include ZeroFormatter::ZeroFormattable
    field :message, :string
  end

  class DataClass
    include ZeroFormatter::ZeroFormattable
    field :child, DataClassChild, nullable: true
  end
end
