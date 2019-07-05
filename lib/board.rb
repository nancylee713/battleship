class Board

  attr_reader :cells

  def initialize
    @cells = make_coordinates
  end

  def make_coordinates
    cell_chars = %w[A B C D]
    cell_nums = %w[1 2 3 4]
    arr_coordinates = cell_chars.map do |char|
      cell_nums.map do |num|
        char + num
      end
    end.flatten

    new_board = {}
    arr_coordinates.each do |coord|
      new_board[coord] = Cell.new(coord)
    end
    new_board
  end

  # def cells
  #   make_coordinates.each do |coord|
  #     @cells.store(coord, Cell.new(coord))
  #   end
  #
  #   @cells
  # end

  def valid_coordinate?(coord)
    cells.keys.include? coord
  end

  def valid_placement?(ship, arr_of_coords)
    all_coords_in_board = arr_of_coords.all? do |coord|
      valid_coordinate?(coord)
    end
    # first check if arr_of_coords are valid coordinates and match ship length
    if all_coords_in_board && ship.length == arr_of_coords.length
      arr_of_coords.each_cons(2).all? do |coord_1, coord_2|
        # horizontally || vertically
        coord_1[0] == coord_2[0] && coord_2[1].to_i == coord_1[1].to_i + 1 || coord_1[1] == coord_2[1] && coord_2[0].ord == coord_1[0].ord + 1
      end
    else
      false
    end
  end


  def place(ship, coords)
      # check if given coordinates are valid & ship length matches
      if valid_placement?(ship, coords)
        @cells.each do |k, v|
          v.place_ship(ship)
        end
      end
    end
end
