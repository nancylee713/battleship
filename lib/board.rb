require "pry"
class Board

  attr_reader :cells

  def initialize
    @cells = {
              "A1" => Cell.new("A1"),
              "A2" => Cell.new("A2"),
              "A3" => Cell.new("A3"),
              "A4" => Cell.new("A4"),
              "B1" => Cell.new("B1"),
              "B2" => Cell.new("B2"),
              "B3" => Cell.new("B3"),
              "B4" => Cell.new("B4"),
              "C1" => Cell.new("C1"),
              "C2" => Cell.new("C2"),
              "C3" => Cell.new("C3"),
              "C4" => Cell.new("C4"),
              "D1" => Cell.new("D1"),
              "D2" => Cell.new("D2"),
              "D3" => Cell.new("D3"),
              "D4" => Cell.new("D4")
              }
            end

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def find_first_coord_element(coordinates)
    first_coord_elements = coordinates.map { |coordinate| coordinate.slice(0).ord}
  end

  def find_second_coord_element(coordinates)
    second_coord_elements = coordinates.map { |coordinate| coordinate.slice(1).to_i}
  end

  def check_consecutive(values)
    values.each_cons(2).all? { |x,y| y == x + 1 }
  end


  def valid_placement?(ship, coordinates)

   if coordinates.all? { |coordinate| valid_coordinate?(coordinate)}

     if ship.length == coordinates.length

      if find_first_coord_element(coordinates).uniq.length == 1 && check_consecutive(find_second_coord_element(coordinates))
        true

      elsif find_second_coord_element(coordinates).uniq.length == 1 && check_consecutive(find_first_coord_element(coordinates))
        true

      else
        false
      end

    else
      false
    end

  else
    false
  end
end
end
