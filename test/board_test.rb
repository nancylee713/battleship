require "MiniTest/autorun"
require "MiniTest/pride"
require './lib/board'
require './lib/cell'
require './lib/ship'

require 'pry'

class BoardTest < MiniTest::Test

  def setup
    @board = Board.new
    @cell = Cell.new("A1")
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_board_is_a_hash
    assert @board.board.instance_of? Hash
  end

  def test_board_contains_16_cells
    assert_equal 16, @board.cells.length
  end

  def test_key_points_to_cell_object
    assert_equal Cell, @board.cells["A1"].class
  end

  def test_coordinate_is_valid
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")
    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("A22")
  end

  def test_number_of_coordinates_in_the_array_match_ship_length
    refute @board.valid_placement?(@cruiser, ["A1", "A2"])
    refute @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
  end

  def test_coordinates_are_consecutive
    refute @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    refute @board.valid_placement?(@submarine, ["A1", "C1"])
    refute @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    refute @board.valid_placement?(@submarine, ["C1", "B1"])
  end

  def test_coordinates_cannot_be_diagonal
    refute @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    refute @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_valid_placements_return_true
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
    assert @board.valid_placement?(@submarine, ["B2", "B3"])
    assert @board.valid_placement?(@submarine, ["D3", "D4"])

    assert @board.valid_placement?(@cruiser, ["A1", "B1", "C1"])
    assert @board.valid_placement?(@cruiser, ["B2", "B3", "B4"])
    assert @board.valid_placement?(@cruiser, ["B2", "C2", "D2"])
  end
end
