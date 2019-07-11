require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class StringPrompts

  def initial_greeting
    puts "=" * 33
    puts ">>  Welcome to BATTLESHIP \n>>  Enter p to play. Enter q to quit."
  end

  def ask_user_input
    user_input = gets.chomp().downcase

    if user_input == 'p'
      determine_board_size

    elsif user_input == 'q'
      exit

    else
      puts "That's not either p or q. Please enter your input again!"
      ask_user_input
    end
  end

  def determine_board_size
    puts "Please specify the board size greater than 3 >> ex) 4 "
  end

  def inquire_cruiser_placement
    puts "=" * 33
    puts "I have laid out my ships on the grid. (It's only visible to me!)"
    puts "You now need to lay out your two ships."
    puts "The Cruiser is 3 units long and the Submarine is 2 units long."
    puts "Enter the squares for the Cruiser (3 spaces) (ex. A1 A2 A3): "
  end

  def inquire_submarine_placement
    puts "=" * 33
    puts "Enter the squares for the Submarine (2 spaces) (ex. C4 D4): "
  end

  def display_computer_board
    puts "=============COMPUTER BOARD============="
  end

  def display_user_board
    puts "==============PLAYER BOARD=============="
  end

  def player_turn_to_fire_on
    puts "=" * 33
    puts "Enter the coordinate for your shot: \n"
  end

  def computer_turn_to_fire_on
    puts "=" * 33
    puts "My turn >>"
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

  def final_menu
    puts "==============FINAL RESULT=============="
  end
end
