require "MiniTest/autorun"
require "MiniTest/pride"
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require 'pry'

class PlayerTest < MiniTest::Test

  def setup
    @board = Board.new

    @tester_ship_1 = Ship.new("Tester_Ship_1",2)
    @tester_ship_2 = Ship.new("Tester_Ship_2",2)
    @computer = Player.new(@board)

  end

  def test_it_exists
    simple_board = Board.new
    simple_board_keys = ["A1", "A2", "B1", "B2"]

    assert_instance_of Player, @computer
  end

  def test_case_name

  end
end
