class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate, ship=nil)
    @coordinate = coordinate
    @ship = ship
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(new_ship)
    @ship = new_ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true

    if @ship == nil
      "M"
    elsif @ship.sunk? == true
      "X"
    else
      @ship.hit
      "H"
    end
  end

  def render
    if @fired_upon
      fire_upon
    elsif @ship != nil
      "S"
    else
      "."
    end
  end

end
