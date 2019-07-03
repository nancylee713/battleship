class Board

  attr_reader :board

  def initialize(board={})
    @board = board
  end

  def make_coordinates
    cell_chars = %w[A B C D]
    cell_nums = %w[1 2 3 4]

    arr_coordinates = cell_chars.map do |char|
      cell_nums.map do |num|
        char + num
      end
    end.flatten
  end

  def cells
    make_coordinates.each do |coord|
      @board.store(coord, Cell.new(coord))
    end

    @board
  end

  def valid_coordinate?(coord)
    cells.keys.include? coord  
  end

end
