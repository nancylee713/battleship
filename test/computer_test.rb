require "MiniTest/autorun"
require "MiniTest/pride"
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/computer'

require 'pry'

class ComputerTest < MiniTest::Test

  def setup
    # @board = Board.new
    # @cell = Cell.new("A1")
    # @cruiser = Ship.new("Cruiser", 3)
    # @submarine = Ship.new("Submarine", 2)
    # @tester_ship_1 = Ship.new("Tester_Ship_1",2)
    # @tester_ship_2 = Ship.new("Tester_Ship_2",2)
    @computer_board = Board.new
    @computer = Computer.new(@computer_board)
  end

  def test_it_exits

    assert_instance_of Computer, @computer
  end

  def test_computer_random_cord
  assert_instance_of String, @computer.computer_random_cord
  end

  def computer_place_ship

  end

end
