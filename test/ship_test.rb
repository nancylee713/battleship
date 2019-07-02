require "MiniTest/autorun"
require "MiniTest/pride"
require './lib/ship'

class ShipTest < MiniTest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_attributes
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
    assert_equal 3, @cruiser.health
    refute @cruiser.sunk?
  end

  def test_hit_decreases_health_by_1
    @cruiser.hit
    assert_equal 2, @cruiser.health
  end

  def test_ship_sunk_when_health_is_0
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit

    assert_equal 0, @cruiser.health
    assert @cruiser.sunk?
  end

  def test_health_cannot_go_below_0
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit

    assert_equal 0, @cruiser.health
  end

end
