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

    loop do
      # Display 2 boards
      @prompts.display_computer_board
      puts @computer_board.render

      @prompts.display_user_board
      puts @user_board.render(true)

      # Player turn
      @prompts.player_turn_to_fire_on

      loop do
        @user_shot_input = gets.chomp()
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

      # Display results
      binding.pry
      puts "Your shot on #{@user_shot_input} was a miss."
      puts "My shot on #{@valid_computer_input[0]} was a miss."


      # When game is over: Break loop when either board has 5 X's
      if @user_board.render(true).count("X") == 5 || @computer_board.render(true).count("X") == 5
        # show result
        break
      end

    end

  end
game = PlayBoardGame.new()
game.setup
game.start
