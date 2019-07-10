require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require './lib/string_prompts'
require 'pry'

class PlayBoardGame

  def setup
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @prompts = StringPrompts.new
  end


  def start

    @prompts.initial_greeting

    # User prompted to play game
    @prompts.ask_user_input
    board_size = gets.chomp().to_i

    # Set up board according to user input
    @computer_board = Board.new(board_size)
    @computer = Player.new(@computer_board)
    @user_board = Board.new(board_size)
    @user = Player.new(@user_board)

    #Computer places ships
    @computer.computer_place_ships(@cruiser)
    @computer.computer_place_ships(@submarine)

    #User prompted to place ships
    @prompts.inquire_cruiser_placement
    @user.user_place_ships(@cruiser)

    @prompts.inquire_submarine_placement
    @user.user_place_ships(@submarine)


   #Turn loop started
    loop do

      @prompts.display_computer_board
      puts @computer_board.render

      @prompts.display_user_board
      puts @user_board.render(true)

      # Player fires upon computer
      @prompts.player_turn_to_fire_on
      @user.fire_upon_computer(@computer_board)

      @prompts.computer_turn_to_fire_on

      #Computer fires upon player
      loop do
        @valid_computer_input = []

        # Select a valid coordinate randomly
        computer_shot_input = @computer_board.cells.keys.sample(1)

        # Computer cannot fire upon cell already fired upon
        unless @user_board.cells[computer_shot_input[0]].fired_upon?
          @valid_computer_input << computer_shot_input[0]
          break
        end
      end

      #Results of turn displayed
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
        puts " "
        @prompts.final_menu
        puts " "
        @prompts.display_computer_board
        puts @computer_board.render(true)
        @prompts.display_user_board
        puts @user_board.render(true)
        puts "I won!"
        break

      elsif @computer_board.render(true).count("X") == 5
        puts " "
        @prompts.final_menu
        puts " "
        @prompts.display_computer_board
        puts @computer_board.render(true)
        @prompts.display_user_board
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
