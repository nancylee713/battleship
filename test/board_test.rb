require "MiniTest/autorun"
require "MiniTest/pride"
require './lib/board'
require './lib/cell'

require 'pry'

class BoardTest < MiniTest::Test

  def setup
    @battle_board = Board.new
    @cell = Cell.new("A1")
  end

  def test_it_exists
    assert_instance_of Board, @battle_board
  end

  def test_board_is_a_hash
    assert @battle_board.board.instance_of? Hash
  end

  def test_board_contains_16_cells
    assert_equal 16, @battle_board.cells.length
  end

  def test_key_points_to_cell_object
    assert_equal Cell, @battle_board.cells["A1"].class
  end
end
