class Grid
  NEIGHBORS = [[-1, -1], [-1, 0], [-1, 1],
               [0, -1],           [0, 1],
               [1, -1],  [1, 0],  [1, 1]]

  def initialize(*initial_state)
    @state = initial_state
  end

  def get_cell(x, y)
    @state.include?([x, y])
  end

  def iterate
    @state = @state.reject do |cell|
      count = get_neighbor_count(cell)
      count < 2 || count > 3
    end
  end

  def get_neighbor_count(cell)
    NEIGHBORS.select do |neighbor|
      get_cell(cell.first - neighbor.first, cell.last - neighbor.last)
    end.count
  end
end
