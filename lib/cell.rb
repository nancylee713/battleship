class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate, ship=nil)
    @coordinate = coordinate
    @ship = ship
  end

  def empty?
    @ship == nil
  end

  def place_ship(new_ship)
    @ship = new_ship
  end

end
