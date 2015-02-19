class Piece
  attr_reader :color, :symbol, :board, :king_promotion
  attr_accessor :position, :valid_jumps, :king, :symbol
  def initialize color, position, board
    @color = color
    @king = false
    @position = position
    @board = board
    @symbol = "\u26C0"
    @king_promotion = @color == :red ? 0 : 7
  end


  def move_directions
    direction = [[1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
    ]
    unless king
      direction = color == :red ? direction[2..3] : direction[0..1]
    end
    direction
  end

  def inspect

  end
  def perform_slide player
    raise WrongPlayerPiece unless color == player.color
    valid_moves = []
    move_directions.each do |move|
      new_pos = [move[0] + position[0], move[1] + position[1]]
      valid_moves << new_pos if board.empty?(new_pos)
    end
    valid_moves
  end

  def perform_jump player
    raise WrongPlayerPiece unless color == player.color
    self.valid_jumps = []
    move_directions.each do |move|
      new_pos = [move[0] + position[0], move[1] + position[1]]

      if board.valid_pos?(new_pos) && !board.empty?(new_pos)
        unless board.color_of_piece_there(new_pos) == color
          eat_move = [(2 * move[0]) + position[0], (2 * move[1]) + position[1]]
          valid_jumps << eat_move if board.empty?(eat_move)
        end
      end

    end
    valid_jumps
  end

  def king_promoted?
    if position[0] == king_promotion
      self.king = true
      self.symbol = "\u265B"
      return true
    end
    false
  end
end
