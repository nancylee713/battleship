class Ship

  attr_reader :name, :length, :health

  def initialize(name, length, health=3)
    @name = name
    @length = length
    @health = health
    @sunk = false
  end

  def sunk?
    if @health == 0
      @sunk = true
    end
  end

  def hit
    @health -= 1
  end

  def health
    if @health < 0
      @health = 0
    else
      @health
    end
  end
end
