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
    #does this method need to handle more than one coordinate
    @cells.key?(coordinate)
  end



  def valid_placement?(ship, coordinates)
    #how to write if all coordinates are valid true
    if coordinates.any? do each something valid_coordinate?
      #how know what ship length is?
      if @ship.length == coordinates.length
        if coordinates.slice(0).unique == 1 && coordinates.slice(1).each_con(1).all?
          true

          elsif coordinates.slice(1).unique == 1 && coordinates.slice(0).ord.each_con(1).all?
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
