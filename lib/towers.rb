class Towers
  attr_accessor :stack

  def initialize
    @stack = [[3, 2, 1], [], []]
  end

  def move from, to
    raise 'error' unless from.between?(0, 2) && to.between?(0, 2)
    raise 'error' if stack[from].empty?
    unless stack[to].empty?
      raise StandardError.new("error") if stack[from].last > stack[to].last
    end
    stack[to] << stack[from].pop
  end

  def won?
    stack == [[], [], [3, 2, 1]]
  end

  def get_user_input
    puts "please input"
    # input = gets.chomp.scan(/\d/).split('')
  end

  def play
    get_user_input
    move(0,2)
    won?
  end
end
