require 'MiniTest/autorun'
require 'MiniTest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class BoardTest < MiniTest::Test

  def setup
  @board = Board.new
  @cruiser = Ship.new("Cruiser", 3)
  @submarine = Ship.new("Submarine", 2)

  end

  # def test_it_exists
  #
  # assert_instance_of Board, @board
  # end
  #
  # def test_it_returns_all_cell_values
  #   skip
  # assert_equal  UNKNOWN ,@board.cells
  # end
  #
  # def test_it_cell_has_valid_coorinates
  #
  # assert @board.valid_coordinate?("A1")
  # assert @board.valid_coordinate?("D4")
  # refute @board.valid_coordinate?("A5")
  # refute @board.valid_coordinate?("E1")
  # refute @board.valid_coordinate?("A22")
  #
  # end

  def test_valid_placement_method


  #refute @board.valid_placement?(@cruiser, ["A1", "A2"])
  #refute @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
  assert_equal true, @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
  end
end
