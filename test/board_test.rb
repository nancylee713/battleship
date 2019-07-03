require "MiniTest/autorun"
require "MiniTest/pride"
require './lib/board'
require './lib/cell'

require 'pry'

class BoardTest < MiniTest::Test

  def setup
    @board = Board.new
    @cell = Cell.new("A1")
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
end
