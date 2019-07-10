class Computer

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


  def fire_on_player_ship
    @POOL_OF_COORDS.sample(1)
  end

  def computer_place_ships(ship)
    computer_valid_coord = select_random_coordinates(ship)
    @board.place(ship, computer_valid_coord)
  end

end
