class Ship

  attr_reader :name, :length, :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
    #health now set to legth
    @sunk = false
  end

  def sunk?
    @health == 0
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
