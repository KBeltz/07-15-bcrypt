require 'minitest/autorun'
require_relative '../models/cyclist.rb'

class CyclistTest < Minitest::Unit::TestCase

  def test_valid?
    name = ""

    assert_empty(name)
  end

end