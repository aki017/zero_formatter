require 'test_helper'

class FpTest < Minitest::Test
  def test_float
    loaddump(:float, 0)
    loaddump(:float, 1)
    loaddump(:float, -1)
    loaddump(:float, 3.4027230684577505e+38)
    loaddump(:float, -3.4027230684577505e+38)
    loaddump(:float, Float::EPSILON)
    loaddump(:float, -Float::EPSILON)
  end

  def test_double
    loaddump(:double, 0)
    loaddump(:double, 1)
    loaddump(:double, -1)
    loaddump(:double, 1.79769313486232E+308)
    loaddump(:double, -1.79769313486232E+308)
    loaddump(:double, Float::EPSILON)
    loaddump(:double, -Float::EPSILON)
  end
end
