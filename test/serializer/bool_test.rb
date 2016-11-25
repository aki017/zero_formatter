require 'test_helper'

class BoolTest < Minitest::Test
  def test_bool
    loaddump(:bool, true)
    loaddump(:bool, false)
  end
end
