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
    if ship_not_already_placed?(arr_of_coords)
      if (arr_of_coords - make_coordinates).empty? && ship.length == arr_of_coords.length
        arr_of_coords.each_cons(2).all? do |coord_1, coord_2|
          # horizontally || vertically
          coord_1[0] == coord_2[0] && coord_2[1].to_i == coord_1[1].to_i + 1 ||
          coord_1[1] == coord_2[1] && coord_2[0].ord == coord_1[0].ord + 1
        end
      end
    end
  end

  #look at arr_of_coords... find those coords as keys in cell hash... look at those keys values
  #determine if those cell objects (value) DO NOT have a ship object --> are empty?
  # example cell objects
  # "A3"=> <Cell:0x007fe924217f90 @coordinate="A3", @fired_upon=false, @ship=#<Ship:0x007fe9242462a0 @health=3, @length=3, @name="Dickbutt", @sunk=false>>,
  # "A4"=> #<Cell:0x007fe924217f40 @coordinate="A4", @fired_upon=false, @ship=nil>
  def ship_not_already_placed?(arr_of_coords)
    # arr of cords = ["A1", "A2", "A3"]
    # check cell hash for matching key with arr_of_coords
    not_placed = true
    arr_of_coords.each do |coord|
      # coord = "A1"
      # @cells = { "A1" => {Cell object}, ...}
      if @cells[coord].ship == nil
        p "no ship at coordinate"
      else
        not_placed = false
        p "ship already here"
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
end
