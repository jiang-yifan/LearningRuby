require 'remove_dups.rb'

describe '#my_uniq' do
  subject(:array) { [1, 2, 1, 3, 3] }

  it 'removes duplicates' do
    expect(array.my_uniq).to eq([1, 2, 3])
  end

  it 'does not modify original array' do
    array.my_uniq
    expect(array).to eq([1, 2, 1, 3, 3])
  end

end

describe '#two_sum' do
  subject(:array) { [] }

  it 'returns two elements that sum to zero' do
    array = [-1, 0, 2, -2, 1]
    expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
  end

  it 'returns elements in proper order' do
    expect([-1, 1, 1].two_sum).to eq([[0, 1], [0, 2]])
  end
end
