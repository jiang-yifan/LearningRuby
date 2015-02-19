class Board
  attr_accessor :board, :last_move, :count, :victor

  def initialize
    @board = Array.new(3) { Array.new(3) }
    @last_move = [0, 0, 'g']
    @count = 0
    @victor = ''
  end

  def won?
     status = check_diagonal || check_horizontal || check_vertical
     victor = last_move[2] if status
     status
  end

  def filled?
    count == 9
  end

  def check_horizontal
    _, y, mark = last_move
    (0..2).to_a.all? do |i|
      board[i][y] == mark
    end
  end

  def check_vertical
    x, _, mark = last_move
    (0..2).to_a.all? do |i|
      board[x][i] == mark
    end
  end

  def check_diagonal
    x, y, mark = last_move
    diag1 = (0..2).to_a.all? do |i|
       board[i][i] == mark
    end

    diag2 = (0..2).to_a.all? do |i|
      board[i][2-i] == mark
    end

    diag1 || diag2
  end



  def winner
    unless victor == ''
      _, _, mark = last_move
      puts "#{ mark } wins!"
    else
      puts "Tie!"
    end
  end

  def empty? position
    x, y = position
    board[x][y] == nil
  end

  def place_mark(pos, mark)
    self.last_move = pos[0], pos[1] , mark
    x, y = pos
    board[x][y] = mark
    self.count += 1
  end

  def render
    (0..2).to_a.map do |i|
      board[i].map do |j|
       j || "X "
      end.join("\t")
    end.join("\n")
  end

  def display
    puts render
  end

  def remove_mark pos
    x, y = pos
    board[x][y] = nil
    self.count -= 1
  end

end

class Game
  attr_reader :board, :humanplayer, :computerplayer

  def initialize
    @board = Board.new
    @turn
    @humanplayer = ComputerPlayer.new "mark"
    @computerplayer = ComputerPlayer.new "sam"
  end

  def play
    until board.won? || board.filled?
      humanplayer.move board
      break if board.won? || board.filled?
      computerplayer.move board
    end
    board.winner
  end

end

class Player
  attr_accessor :name, :pos

  def initialize name
    @name = name
    @pos = []
  end

  def move board
    get_move board
    until board.empty? pos
      puts "Board not empty"
      get_move board
    end
    board.place_mark pos, name
    board.display
  end
end

class HumanPlayer < Player

  def get_move board
    puts " Please enter the row:"
    pos[0] = gets.chomp.to_i
    puts "Please enter a column:"
    pos[1] = gets.chomp.to_i
  end

end

class ComputerPlayer < Player


  def get_move board
    opponent = board.last_move[2]
    block_move = []
    possible_moves = []
    (0..2).to_a.each do |x|
      (0..2).to_a.each do |y|
        if board.board[x][y] == nil
          board.place_mark [x,y], name
          if board.won?
            self.pos = [x, y]
            board.remove_mark [x,y]
            return
          end
          board.remove_mark [x,y]

          board.place_mark [x,y], opponent
          if board.won? && block_move.empty?
            block_move = [x, y]
          end


          board.remove_mark [x, y]
          possible_moves << [x, y]
        end
      end
    end

    if block_move.empty?
      self.pos = possible_moves.sample
    else
      self.pos = block_move
    end
  end
end

game = Game.new
game.play
