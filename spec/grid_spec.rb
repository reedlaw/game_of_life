require 'grid'

describe Grid do
  context '#get_cell' do
    let(:subject) { described_class.new([10, 10]) }

    it 'returns cell state' do
      subject.get_cell(10, 10).should be_true
    end

    it 'returns false if no live cell' do
      subject.get_cell(0, 0).should be_false
    end
  end

  context '#iterate' do
    it 'kills cells with fewer than 2 neighbors' do
      subject.iterate
      subject.get_cell(10, 10).should be_false
      grid1 = described_class.new([10, 10])
      grid1.iterate
      grid1.get_cell(10, 10).should be_false
    end

    it 'preserves cells with 2 or more neighbors' do
      grid = described_class.new([10, 10], [11, 11], [9, 9])
      grid.iterate
      grid.get_cell(10, 10).should be_true
    end

    it 'kills cells with more than 3 neighbors' do
      grid = described_class.new([10, 10], [11, 10], [11, 11], [9, 9], [9, 10])
      grid.iterate
      grid.get_cell(10, 10).should be_false
    end
  end

  context '#get_neighbor_count' do
    it 'returns number of neigbors' do
      grid1 = described_class.new([10, 10])
      grid1.get_neighbor_count([10, 10]).should eq(0)
      grid2 = described_class.new([10, 10], [9, 9])
      grid2.get_neighbor_count([10, 10]).should eq(1)
    end
  end
end
