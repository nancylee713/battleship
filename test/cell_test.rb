require "MiniTest/autorun"
require "MiniTest/pride"
require './lib/ship'
require './lib/cell'
require 'pry'

class CellTest < MiniTest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C3")
  end

  def test_it_exists

    assert_instance_of Cell, @cell_1
  end

  def test_coordinate_method

    assert_equal "B4", @cell_1.coordinate
  end

  def test_coordinate_does_not_contain_ship

    assert_nil @cell_1.ship
  end

  def test_cell_is_empty_when_no_ship_placed

    assert @cell_1.empty?
  end

  def test_ship_can_be_placed_in_cell
    @cell_1.place_ship(@cruiser)

  assert_equal @cruiser, @cell_1.ship
  end

  def test_cell_is_not_empty_when_ship_placed
    @cell_1.place_ship(@cruiser)

    refute @cell_1.empty?
  end

  def test_it_can_be_fired_upon
    refute @cell_1.fired_upon?
  end

  def test_health_decreases_when_fire_upon
    @cell_1.place_ship(@cruiser)
    @cell_1.fire_upon
    assert_equal 2, @cell_1.ship.health
  end

  def test_it_renders_dot_when_not_fired_upon
    assert_equal ".", @cell_1.render
  end

  def test_it_renders_M_when_fired_upon_and_no_ship
    @cell_1.fire_upon
    assert_equal "M", @cell_1.render
  end

  def test_it_renders_H_when_fired_upon_and_ship_placed
    @cell_1.place_ship(@cruiser)
    @cell_1.fire_upon
    assert_equal "H", @cell_1.render
  end

  def test_it_renders_X_when_fired_upon_and_ship_sunk
    @cell_1.place_ship(@cruiser)
    @cell_1.fire_upon
    @cell_1.fire_upon
    @cell_1.fire_upon
    assert_equal "X", @cell_1.render
  end

  def test_it_renders_H_when_fired_upon_and_ship_placed
    @cell_1.place_ship(@cruiser)
    assert_equal "S", @cell_1.render
  end

end
