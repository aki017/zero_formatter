require 'test_helper'

class IntTest < Minitest::Test
  def test_int8
    max = 1 << (8-1) - 1
    loaddump(:int8, 0)
    loaddump(:int8, -1)
    loaddump(:int8, -max)
    loaddump(:int8, 1)
    loaddump(:int8, max)
  end

  def test_int16
    max = 1 << (16-1) - 1
    loaddump(:int16, 0)
    loaddump(:int16, -1)
    loaddump(:int16, -max)
    loaddump(:int16, 1)
    loaddump(:int16, max)
  end

  def test_int32
    max = 1 << (32-1) - 1
    loaddump(:int32, 0)
    loaddump(:int32, -1)
    loaddump(:int32, -max)
    loaddump(:int32, 1)
    loaddump(:int32, max)
  end

  def test_int64
    max = 1 << (64-1) - 1
    loaddump(:int64, 0)
    loaddump(:int64, -1)
    loaddump(:int64, -max)
    loaddump(:int64, 1)
    loaddump(:int64, max)
  end
end
