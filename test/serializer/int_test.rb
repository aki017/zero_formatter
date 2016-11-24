require 'test_helper'

class ZeroFormatterTest < Minitest::Test
  def test_int8
    loaddump(:int8, 0)
    loaddump(:int8, -1)
  end


end
