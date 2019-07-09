class Computer

  def initialize(board)
    @board = board
    @POOL_OF_COORDS = @board.cells.keys
    @test_array = []
    @test_array_2 = []
    @valid_coords = []
    @valid_coords_2 = []
  end


  def select_random_coordinates(ship)

    until coords.valid_placement == true

    random_number = [0, 1].sample(1)[0]

      if random_number == 1   # horizontally
        @POOL_OF_COORDS.each_slice(4) { |set| @test_array <<  set }
        @test_array.each do |arr|
          arr.each_cons(ship.length) { |set| @valid_coords << set }
        end
        coords = @valid_coords.sample(1)

      else # vertically
        sorted_pool = @POOL_OF_COORDS.sort_by {|n| n[1]}
        sorted_pool.each_slice(4) { |set| @test_array_2 << set }
        @test_array_2.map!(&:sort)
        @test_array_2.each do |arr|
          arr.each_cons(ship.length) { |set| @valid_coords_2 << set }
        end
        @valid_coords_2.sample(1)
        coords = valid @valid_coords.sample(1)
      end
    end
  end
end
