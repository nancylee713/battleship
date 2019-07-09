require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class StringPrompts

  def initial_greeting
    puts "=" * 33
    puts ">>  Welcome to BATTLESHIP \n>>  Enter p to play. Enter q to quit."
  end

  def start_game_valid(user_input)
    if user_input == 'p'
      puts "Setting up the board now ..."

    elsif user_input == 'q'
      exit

    else
      puts "That's not either p or q. Please enter your input again!"
      start_game_valid
    end
  end

  def inquire_cruiser_placement
    puts "=" * 33
    puts "I have laid out my ships on the grid. (It's only visible to me!)"
    puts "You now need to lay out your two ships."
    puts "The Cruiser is 3 units long and the Submarine is 2 units long."
    puts "Enter the squares for the Cruiser (3 spaces) (ex. A1 A2 A3): "

    # check_user_placement => redo or render board
  end

  def inquire_submarine_placement
    puts "Enter the squares for the Submarine (2 spaces) (ex. C4 D4): "
    # check_user_placement
  end

  def fire_upon_computer
    puts "Enter the coordinate for your shot:"
  end

  def display_computer_board
    puts "=============COMPUTER BOARD============="
  end

  def display_player_board
    puts "==============PLAYER BOARD=============="
  end 
end
