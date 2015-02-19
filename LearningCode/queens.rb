class Board
  attr_accessor :bd, :x, :y, :moves

  def initialize
    @bd = Array.new(8) {Array.new(8, "empty")}
    @pos = []
    @moves = []
  end

  def check? pos
    self.y, self.x = pos

    check_vertical || check_diagonal
  end

  def check_vertical

    8.times.any? do |i|
      bd[i][x] == "Q"
    end
  end

  def check_diagonal
    min1 = 0 - [y , x].min
    max1 = [7 - y, 7 - x].min

    diag1 = (min1..max1).to_a.any? do |i|
      bd[y+i][x+i] == "Q"
    end

    min2 = 0 - [7 - x, y].min
    max2 = [7 - y, x].min

    diag2 =(min2..max2).to_a.any? do |i|

      bd[y+i][x-i] == "Q"
    end

    diag1 || diag2


  end

  def place_queen

    bd[y][x] = "Q"
    moves << [y, x]

  end

  def remove_queen

    y, x = moves.pop
    bd[y][x] = "empty"

  end


end

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def play y = 0
    (0..7).to_a.each do |x|
      if !board.check? [y, x]
        if y == 7
          board.place_queen
          won
          break
        else
          board.place_queen
          play y + 1
        end
      end
    end
    board.remove_queen

  end

  def won
    (0..7).to_a.each do |y|
      (0..7).to_a.each do |x|
      print "#{board.bd[y][x]} \t"
      end
      print "\n"
    end

  end
end

game = Game.new

game.play
