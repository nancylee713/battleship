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
    @user = Player.new(@board)

  end

  def test_it_exists
    simple_board = Board.new
    simple_board_keys = ["A1", "A2", "B1", "B2"]

    assert_instance_of Player, @computer
  end

  def test_computer_can_randomly_select_coordinates_to_place_ship
    computer_choice = @computer.select_random_coordinates(@tester_ship_1)
    valid_coord_pool = @board.cells.keys

    # test random coordinates belong to the valid pool of 16 coordinates
    assert_empty computer_choice - valid_coord_pool

    # test the length of a given ship matches # of random coordinates selected
    assert_equal @tester_ship_1.length, computer_choice.length
  end

end
