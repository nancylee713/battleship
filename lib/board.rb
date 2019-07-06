class Board

  attr_reader :cells

  def initialize
    @cells = all_cells
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

  def all_cells
    coordinates = {}
    make_coordinates.each do |coord|
      coordinates.store(coord, Cell.new(coord))
      # same as coordinates[coord] = Cell.new(coord))
    end
    coordinates
  end

  # def valid_coordinate?(coord)
  #   @cells.keys.include? coord
  # end

  def valid_placement?(ship, arr_of_coords)
    # first check if arr_of_coords are valid coordinates and match ship length

    if (arr_of_coords - make_coordinates).empty? && ship.length == arr_of_coords.length
      arr_of_coords.each_cons(2).all? do |coord_1, coord_2|
        # horizontally || vertically
        coord_1[0] == coord_2[0] && coord_2[1].to_i == coord_1[1].to_i + 1 ||
        coord_1[1] == coord_2[1] && coord_2[0].ord == coord_1[0].ord + 1
      end
    else
      false
    end
  end

  def place(ship, coords)
    # check if given coordinates are valid & ship length matches
    if valid_placement?(ship, coords)
      @cells.each_pair do |k, v|
        if coords.include? k
          v.place_ship(ship)
        end
      end
    end
  end

  def render

  end

end
