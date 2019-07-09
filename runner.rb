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
    take_turn
    #loop within start, resposible for just one turn

  end

  def take_turn
    #how does compt know when all ship sunk?
    #all ship cells are maked as 'X

    #1. Diplay Board
    #2. Player choose coords to fire_upon
    #3. Computer choose choords fire_upon
    #4. Report result of player shot
    #5. report result of compt.
    until if user_board.cells.cruiser.sunk? && user_board.cells.submarine.sunk? || computer_board.cells.cruiser.sunk? && computer_board.cells.submarine.sunk?
    do loop
      #until loop number of X equal 5... loop until false
      @prompts.display_player_board
      user.board.render
      @prompts.display_computer_board
      computer.board.render

      @prompts.fire_upon_computer
      user_input_fire_upon = gets.chomp().split
      user_input_fire_upon.valid_coordinate?



    # if all user_board.cells == board.cells.render("X")
    #   "game over :("
    #     count of ships = X
      break
  end
end
  # How to take turns b/w computer and user?
end

game = PlayBoardGame.new()
game.setup
game.start
