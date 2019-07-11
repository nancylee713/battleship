class Player

  def initialize(board)
    @board = board
    @POOL_OF_COORDS = @board.cells.keys
  end


  def select_random_coordinates(ship)
    test_array = []
    test_array_2 = []
    valid_coords = []
    valid_coords_2 = []
    result = []

    loop do
      # horizontally
      @POOL_OF_COORDS.each_slice(4) { |set| test_array <<  set }
      test_array.each do |arr|
        arr.each_cons(ship.length) { |set| valid_coords << set }
      end

      # vertically
      sorted_pool = @POOL_OF_COORDS.sort_by {|n| n[1]}
      sorted_pool.each_slice(4) { |set| test_array_2 << set }
      test_array_2.map!(&:sort)
      test_array_2.each do |arr|
        arr.each_cons(ship.length) { |set| valid_coords_2 << set }
      end

      # select 1 sample from the combination of horizontals & verticals
      coords = valid_coords.push(valid_coords_2).sample(1).flatten

      # break loop condition
      if @board.valid_placement?(ship, coords)
        result << coords
        break
      end
    end
    result.flatten
  end


  def computer_place_ships(ship)
    computer_valid_coord = select_random_coordinates(ship)
    @board.place(ship, computer_valid_coord)
  end

  def user_place_custom_ships(board_size)
    loop do
      puts "What do you want to call your ship?"
      user_ship_name = gets.chomp().capitalize

      puts "How long is your ship?"
      puts "** Note that it must fit the board size of your choice."
      user_ship_length = gets.chomp().to_i

        if user_ship_length > board_size
          puts "Oops, your ship is too big for this board. Please try again!"
          puts "How long is your ship?"
          puts"** Note that it must fit the board size of your choice."
          user_ship_length = gets.chomp().to_i
        end

      @ship = Ship.new(user_ship_name, user_ship_length)

      puts "Where do you want to place your ship? (Ex. A1 B1 C1) "

      valid_coords = false

      until valid_coords
        @user_ship_coords = gets.chomp().upcase.split
        valid_spot = @board.valid_placement?(@ship, @user_ship_coords)

        if !valid_spot
          puts "Invalid coordinates. Please try again."
        else
          valid_coords = true
        end
      end

      @board.place(@ship, @user_ship_coords)
      puts @board.render(true)


      puts "Do you want to make another ship? (y/n)"
      user_input = gets.chomp().downcase

      if ['y', 'n'].none? user_input
        puts "Ooops, this isn't either yes or no. Please try again!"
        puts "Do you want to make another ship? (y/n)"
        user_input = gets.chomp().downcase
      end

      if user_input == 'n'
        break
      end
    end
  end


  def fire_upon_computer(computer_board)

    ready_to_fire = false

    until ready_to_fire
      user_shot_input = gets.chomp().upcase

      valid_coordinate = computer_board.valid_coordinate? user_shot_input

      if !valid_coordinate
        puts "Please enter a valid coordinate: "
      elsif computer_board.cells[user_shot_input].fired_upon?
        puts "Sorry, you've already fired upon that coordinate. Please try again: "
      else
        ready_to_fire = true
      end
    end

    computer_board.cells[user_shot_input].fire_upon
  end
end
