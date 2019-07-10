require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'
require './lib/string_prompts'
require 'pry'

# TO DO
# _ player cannot fire upon cell that is already fired fire_upon ??? testing
# - friendlier prompts
# - refactor runner
# _ end of game returns back to the main file
# - start looking at expanding board
# - bug with checking if cell fired upon
# - bug with user input in starting game
# - make user place ship step in runner into method in computer class

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
    user_participation = gets.chomp().downcase

    # User input valid? (=p)
    @prompts.start_game_valid(user_participation)

    #computer places ships
    @computer.computer_place_ships(@cruiser)
    @computer.computer_place_ships(@submarine)

    @prompts.inquire_cruiser_placement

    loop do
      user_cruiser_input = gets.chomp().upcase.split
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
      user_submarine_input = gets.chomp().upcase.split
      valid_input = @user_board.valid_placement?(@submarine, user_submarine_input)
      if valid_input
        @user_board.place(@submarine, user_submarine_input)
        puts @user_board.render(true)
        break
      end
      puts "Those are invalid coordinates. Please try again: \n>"
    end

    loop do
      # Display 2 boards
      @prompts.display_computer_board
      puts @computer_board.render

      @prompts.display_user_board
      puts @user_board.render(true)

      # Player turn
      @prompts.player_turn_to_fire_on

      # STILL WORKING: The user should not fire on a space that has already been fired on.
      loop do
        @user_shot_input = gets.chomp().upcase
        valid_coordinate = @user_board.valid_coordinate? @user_shot_input
        if valid_coordinate
          @computer_board.cells[@user_shot_input].fire_upon
          break
        end
        puts "Please enter a valid coordinate: "
      end

      # Computer turn
      @prompts.computer_turn_to_fire_on

      loop do
        @valid_computer_input = []

        # Select a valid coordinate randomly
        computer_shot_input = @computer_board.cells.keys.sample(1)

        # The computer should not fire on a space that has already been fired on.
        unless @user_board.cells[computer_shot_input[0]].fired_upon?
          @valid_computer_input << computer_shot_input[0]
          break
        end
      end

      @user_board.cells[@valid_computer_input[0]].fire_upon

      user_shot_result = ""
      computer_shot_result = ""

      # Did computer hit, miss or sunk ship on user board?
      coords_user_ships = @user_board.cells.select {|k, v| v.ship != nil }.map {|k, v| v.coordinate }

      if coords_user_ships.include? @valid_computer_input[0]
        computer_shot_result += "hit"
      else
        computer_shot_result += "miss"
      end

      # Did user hit, miss or sunk ship on computer board?
      coords_computer_ships = @computer_board.cells.select {|k, v| v.ship != nil }.map {|k, v| v.coordinate }

      if coords_computer_ships.include? @user_shot_input
        user_shot_result += "hit"
      else
        user_shot_result += "miss"
      end

      puts "Your shot on #{@user_shot_input} was a #{user_shot_result}."
      puts "My shot on #{@valid_computer_input[0]} was a #{computer_shot_result}."


      # When game is over: Break loop when either board has 5 X's
      if @user_board.render(true).count("X") == 5
        @prompts.final_menu
        puts @computer_board.render(true)
        puts @user_board.render(true)
        puts "I won!"
        break
      elsif @computer_board.render(true).count("X") == 5
        @prompts.final_menu
        puts @computer_board.render(true)
        puts @user_board.render(true)
        puts "You won!"
        break
      end

    end

  end

end

game = PlayBoardGame.new()
game.setup
game.start
