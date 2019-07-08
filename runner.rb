require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/string_prompts'
require 'pry'

class PlayBoardGame

  def setup
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @prompts = StringPrompts.new
    @computer_board = Board.new
    @user_board = Board.new
  end

  def start
    # Welcome, p or q?
    @prompts.initial_greeting

    # Save user input
    user_participation = $stdin.gets.chomp()

    # User input valid? (=p)
    @prompts.start_game_valid(user_participation)

    # Computer ship placement & render the board
    @computer_board.place(@cruiser, ["D1", "D2", "D3"])
    puts @computer_board.render

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

  end

  # How to take turns b/w computer and user?


end

game = PlayBoardGame.new()
game.setup
game.start
