class Cell
  attr_reader :coordinate, :ship, :fire_upon

  def initialize(coordinate, ship = nil)
    @coordinate = coordinate
    #something that changes @ship to string when ship placed
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
    # if ship there is a ship and fired upon is false, then ship hit
    if @ship != nil
      @ship.hit
    end

    #Added line that changes @fire_upon to true
    @fire_upon = true
  end

  #arg in render set to false unless specified
  def render(ship_but_not_fired = false)

    if ship_but_not_fired == true
      "S"
    elsif @fire_upon == true && @ship = nil
      "M"
    elsif @fire_upon == true && @ship != nil
      "H"
    elsif @fire_upon == true && @ship != nil && @ship.health == 0
      "X"
    else
      "."
    end
  end

end
