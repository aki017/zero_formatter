require 'test_helper'

class StringTest < Minitest::Test
  def test_char
    (0x0000..0xffff).each do |b|
      str = "" << b rescue next
      loaddump(:char, str)
    end
  end

  def test_string
    loaddump(:string, "test")
    loaddump(:string, "1234")
    loaddump(:string, "テスト")
    loaddump(:string, "")
    loaddump(:string, "♪")
    loaddump(:string, "")
    loaddump(:string, " "*128)
    loaddump(:string, " "*1024)
  end
end
