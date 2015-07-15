require 'minitest/autorun'
require_relative '../models/bike.rb'

class BikeTest < Minitest::Unit::TestCase

  def test_valid?
    bike_name = ""

    assert_empty(bike_name)
  end

end