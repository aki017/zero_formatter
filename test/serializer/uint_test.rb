require 'test_helper'

class UIntTest < Minitest::Test
  def test_uint8
    max = 1 << (8) - 1
    loaddump(:uint8, 0)
    loaddump(:uint8, 1)
    loaddump(:uint8, max)
  end

  def test_uint16
    max = 1 << (16) - 1
    loaddump(:uint16, 0)
    loaddump(:uint16, 1)
    loaddump(:uint16, max)
  end

  def test_uint32
    max = 1 << (32) - 1
    loaddump(:uint32, 0)
    loaddump(:uint32, 1)
    loaddump(:uint32, max)
  end

  def test_uint64
    max = 1 << (64) - 1
    loaddump(:uint64, 0)
    loaddump(:uint64, 1)
    loaddump(:uint64, max)
  end
end
