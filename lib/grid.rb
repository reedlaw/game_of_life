class Grid
  attr_accessor :state

  NEIGHBORS = [[-1, -1], [-1, 0], [-1, 1],
               [ 0, -1],          [ 0, 1],
               [ 1, -1], [ 1, 0], [ 1, 1]]

  def initialize(*initial_state)
    @state = initial_state
  end

  def get_cell(x, y)
    @state.include?([x, y])
  end

  def iterate
    new_cells = get_new_cells
    @state = @state.reject do |cell|
      count = get_neighbor_count(cell)
      count < 2 || count > 3
    end + new_cells
    @state.uniq!
  end

  def get_new_cells
    @state.each_with_object([]) do |cell, array|
      NEIGHBORS.select do |neighbor|
        x = cell.first - neighbor.first
        y = cell.last - neighbor.last
        if !get_cell(x, y) && get_neighbor_count([x, y]) > 2
          array << [x, y]
        end
      end
    end
  end

  def get_neighbor_count(cell)
    NEIGHBORS.select do |neighbor|
      get_cell(cell.first - neighbor.first, cell.last - neighbor.last)
    end.count
  end
end
