# set up ships
# choose ships to randomly fire upon.
require 'pry'

class Computer

  def initialize(board)
    @board = board
    #might have to also initialize with user board.
  end

  def computer_random_cord
    @board.cells.keys.sample
  end

  def computer_place_ship(ship)
    random_coord = computer_random_cord #A1
    number_of_coords = ship.length
    ship_coords = []

    horizontal_or_vertical
      if horizontal_or_vertical == 0 # A1
        #takes in ship length --> returns X number of ship_coords
        # if ship length 2 ... 1 2, 2 3, 3 4 ... method to create pairs?
        # look at each_slice to compare coord value.
        # loop to check valid.
    end

    ship_coords
  end

  def horizontal_or_vertical
    random_num = rand(0..1)
  end
  #will I need user_board? --> might have to pass user board.
end
