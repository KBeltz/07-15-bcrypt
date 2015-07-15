require 'minitest/autorun'
require_relative '../models/ride.rb'

class RideTest < Minitest::Unit::TestCase

  def test_valid?
    miles = ""

    assert_empty(miles)
  end

end