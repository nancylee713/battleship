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

  def inquire_user_ship_placement(board_size)
    puts "=" * 33
    puts "I have laid out my ships on the grid. (It's only visible to me!)"
    puts "Now it's your turn to lay out your ships."

    user_ships = []

    loop do
      puts "What do you want to call your ship?"
      user_ship_name = gets.chomp().capitalize

      puts "How long is your ship?"
      puts"** Note that it must fit the board size of your choice."
      user_ship_length = gets.chomp().to_i

        if user_ship_length > board_size
          puts "Oops, your ship is too big for this board. Please try again!"
          puts "How long is your ship?"
          puts"** Note that it must fit the board size of your choice."
          user_ship_length = gets.chomp().to_i
        end

      puts "Do you want to make another ship? (y/n)"
      user_input = gets.chomp().downcase

        if ['y', 'n'].none? user_input
          puts "Ooops, this isn't either yes or no. Please try again!"
          puts "Do you want to make another ship? (y/n)"
          user_input = gets.chomp().downcase
        end

      user_ship = [user_ship_name, user_ship_length]
      user_ships << user_ship

      if user_input == 'n'
        break
      end

      user_ships
    end

    puts "Here are a list of ships that you've just created: "
    user_ships.each {|ship| p ship}
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
    # The computer should choose a random space on the board.
    # The computer should not fire on a space that has already been fired on.

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
