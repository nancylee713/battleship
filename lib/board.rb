require './lib/cell'

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

  # not used within class, only used for test
  # def valid_coordinate?(coord)
  #   @cells.keys.include? coord
  # end

  def valid_placement?(ship, arr_of_coords)
    if (arr_of_coords - make_coordinates).empty? && ship.length == arr_of_coords.length
    if ship_not_already_placed?(arr_of_coords)
        arr_of_coords.each_cons(2).all? do |coord_1, coord_2|
          # horizontally || vertically
          coord_1[0] == coord_2[0] && coord_2[1].to_i == coord_1[1].to_i + 1 ||
          coord_1[1] == coord_2[1] && coord_2[0].ord == coord_1[0].ord + 1
        end
      end
    end
  end


  def ship_not_already_placed?(arr_of_coords)
    not_placed = true
    arr_of_coords.each do |coord|
      if @cells[coord].ship == nil
      else
        not_placed = false
        return
      end
    end
    not_placed
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

  def render(display_ship=false)
    # Still working: optional argument whether to show hidden ships or not

    # 1. Create an array of dots (initial cell status) by calling .render on each cell object
    # 2. Create an array of subarrays that represent each row on the board (i.e., game_board)
    # 3. Add a top layer (i.e., cell_num) to the array of dots.
    # 4. Insert alphabet (i.e., cell_char) after every 4th element.
    # 5. Flatten the resulting array and insert a whitespace at index 0.
    # 6. Slice the array into 5 rows, then transform each row as a string.
    # 7. Remove the trailing 'nil' & add a whitespace at the end of each row.
    # 8. Finally join them with a newline as a delimiter to match the exact grid format.

    # Setup ============
    cell_chars = %w[A B C D]
    cell_nums = %w[1 2 3 4]
    rows = []
    game_board = []

    @cells.each_pair do |k, v|
      if display_ship == false && v.render == 'S'
        rows << '.'
      else
        rows << v.render
      end
    end

    # Processing ============
      (cell_nums + rows).each_slice(4).zip(cell_chars)
      .flatten
      .unshift("")
      .each_slice(5) { |row| game_board << row.join(' ') }

      game_board.tap(&:pop).map { |e| e + " " }.join("\n") + "\n"
    end

end
