class Cell
  attr_reader :coordinate, :ship, :fire_upon

  def initialize(coordinate, ship=nil)
    @coordinate = coordinate
    @ship = ship
    @fire_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(new_ship)
    @ship = new_ship
  end

  def fired_upon?
    @fire_upon
  end

  def fire_upon
    @ship.hit
  end

  def render
    if fire_upon
      "."
    elsif fired_upon? && empty?
      "M"
    elsif fired_upon? && @ship != nil
      "H"
    elsif fired_upon? && @ship.sunk?
      "X"
    else
      "Error"
    end
  end

end
