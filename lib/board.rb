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

  def render(hidden=false)
    #puts five lines
    #puts first lines with 1..4
    #puts second line with A and cell_object.render? all cells with "A" coords
    #puts third line with B and cell_object.render? all cells with "B" coords
    #puts third line with C and cell_object.render? all cells with "C" coords
    #puts third line with D and cell_object.render? all cells with "D" coords
    # optional argument whether to show hidden ships or not
    if hidden == true
    else
      game = [
        " 1 2 3 4 ",
        "A . . . . ",
        "B . . . . ",
        "C . . . . ",
        "D . . . . "
      ].join("\n") + "\n"
    end
  end

end
