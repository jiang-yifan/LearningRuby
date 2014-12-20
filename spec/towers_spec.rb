require 'towers'

describe '#move' do
  subject(:towers) {Towers.new}

  it 'moves a piece' do
    towers.stack = [[3, 2, 1], [], []]
    towers.move(0, 2)
    expect(towers.stack).to eq([[3, 2], [], [1]])
  end

  it 'does not move bigger pieces to smaller piece' do
    towers.stack = [[3, 2], [], [1]]
    expect { towers.move(0, 2) }.to raise_error("error")
  end

  it 'does not move pieces beyond three stacks' do
    expect { towers.move(0, -1) }.to raise_error("error")
  end

  it 'does not move nothing' do
    expect { towers.move(1, 2) }.to raise_error("error")
  end
end

describe '#won?' do
  subject(:towers) { Towers.new }

  it 'correctly wins' do
    towers.stack = [[], [], [3, 2, 1]]
    expect(towers.won?).to eq(true)
  end

  it 'wins' do
    towers.stack = [[1], [], [3, 2]]
    towers.move(0, 2)
    expect(towers.won?).to eq(true)
  end

  it 'does not win without proper ending stack' do
    expect(towers.won?).to eq(false)
  end
end

describe '#play' do
  subject(:towers) { Towers.new }

  it 'calls the right methods' do
    expect(towers).to receive(:get_user_input)
    expect(towers).to receive(:move)
    towers.play
  end
end
# describe '#get_user_input' do
#   subject(:towers) { Towers.new }
#
#   it 'gets the input' do
#     expect(towers.get_user_input).to eq([0, 1$$])
#   end
# end
