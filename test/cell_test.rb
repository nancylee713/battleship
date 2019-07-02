require "MiniTest/autorun"
require "MiniTest/pride"
require './lib/ship'
require './lib/cell'

class CellTest < MiniTest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
    @cell = Cell.new("B4")
  end

  def test_it_exists

    assert_instance_of Cell, @cell
  end

  def test_coordinate_method

    assert_equal "B4", @cell.coordinate
  end

  def test_coordinate_does_not_contain_ship

    assert_nil @cell.ship
  end

  def test_cell_is_empty_when_no_ship_placed

    assert @cell.empty?
  end

  def test_ship_can_be_placed_in_cell
    @cell.place_ship(@cruiser)

  assert_equal @cruiser, @cell.ship
  end

  def test_cell_is_not_empty_when_ship_placed
    @cell.place_ship(@cruiser)

    refute @cell.empty?
  end

  def test_it_can_be_fired_upon
    refute @cell.fired_upon?
  end

  def test_health_decreases_when_fire_upon
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal 2, @cell.ship.health
  end
end
