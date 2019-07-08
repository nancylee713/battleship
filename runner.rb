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
    @prompts.inquire_cruiser_placement

    # Save user input of 3 coordinates for cruiser & convert to array
    user_cruiser_input = $stdin.gets.chomp()
    user_cruiser_placement = user_cruiser_input.split

    # Check whether user input is valid for cruiser


    loop do
      if @user_board.valid_placement?(@cruiser, user_cruiser_placement)
        # Place cruiser and render board
        @user_board.place(@cruiser, user_cruiser_placement)
        puts @user_board.render(true)
        break
      end

      puts "Those are invalid coordinates. Please try again:"
      next
    end

    # Save user input of 2 coordinates for submarine
    @prompts.inquire_submarine_placement
    user_submarine_input = $stdin.gets.chomp()
    user_submarine_placement = user_submarine_input.split

    # Check whether user input is valid for submarine

    # Place submarine and render board
    @user_board.place(@submarine, user_submarine_placement)
    puts @user_board.render(true)
    # How to take turns b/w computer and user?

  end


end

game = PlayBoardGame.new()
game.setup
game.start
