require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'
require './lib/string_prompts'
require 'pry'

class PlayBoardGame

  def setup
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @prompts = StringPrompts.new
    @computer_board = Board.new
    @computer = Computer.new(@computer_board)
    @user_board = Board.new
  end

  def start
    # Welcome, p or q?
    @prompts.initial_greeting

    # Save user input
    user_participation = $stdin.gets.chomp()

    # User input valid? (=p)
    @prompts.start_game_valid(user_participation)

    # Computer ship placement for cruiser
    computer_valid_coord = @computer.select_random_coordinates(@cruiser)
    @computer_board.place(@cruiser, computer_valid_coord.flatten)

    # Computer ship placement for submarine & render board
    computer_valid_coord = @computer.select_random_coordinates(@submarine)

    @computer_board.place(@submarine, computer_valid_coord.flatten)
    puts @computer_board.render(true)
    # Stay in loop until cruiser has valid placement
    @prompts.inquire_cruiser_placement

    loop do
      user_cruiser_input = gets.chomp().split
      valid_input = @user_board.valid_placement?(@cruiser, user_cruiser_input)
      if valid_input
        @user_board.place(@cruiser, user_cruiser_input)
        puts @user_board.render(true)
        break
      end
      puts "Those are invalid coordinates. Please try again: \n>"
    end

    # Same for submarine
    @prompts.inquire_submarine_placement

    loop do
      user_submarine_input = gets.chomp().split
      valid_input = @user_board.valid_placement?(@submarine, user_submarine_input)
      if valid_input
        @user_board.place(@submarine, user_submarine_input)
        puts @user_board.render(true)
        break
      end
      puts "Those are invalid coordinates. Please try again: \n>"
    end
    take_turn
    #loop within start, resposible for just one turn

    # Display 2 boards
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render

    puts "==============PLAYER BOARD=============="
    puts @user_board.render(true)

    # Player turn

    @prompts.player_turn_to_fire_on

    loop do
      user_shot_input = gets.chomp()
      valid_coordinate = @user_board.valid_coordinate? user_shot_input
      if valid_coordinate
        @user_board.cells[user_shot_input].fire_upon
        puts @user_board.render(true)
        break
      end
      puts "Please enter a valid coordinate: "
    end

  end

  #   # if all user_board.cells == board.cells.render("X")
  #   #   "game over :("
  #   #     count of ships = X
  #     break
  # end
end
  # How to take turns b/w computer and user?


game = PlayBoardGame.new()
game.setup
game.start
