require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos  = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
      return false if board.tied? || board.winner == evaluator
      return true if board.winner != evaluator
    end

    if evaluator == next_mover_mark # check if evaluator's turn
      return true if children.all? { |node| node.losing_node?(evaluator) }
    else
      return true if children.any? { |node| node.losing_node?(evaluator) }
    end

    false
  end

  def winning_node?(evaluator)
    if board.over?
      return true if board.winner == evaluator
      return false if board.winner != evaluator || board.tied?
    end
    # children.each do |child|
    #   child.board.rows.each { |row| p row }
    # puts
    # end
    if evaluator == next_mover_mark # check if evaluator's turn
      return true if children.any? { |node| node.winning_node?(evaluator) }
    else
      return true if children.all? { |node| node.winning_node?(evaluator) }
    end

    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    next_nodes = []
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |el, j|
        if el.nil?
          new_board = board.dup
          new_board[[i, j]]= next_mover_mark
          new_mark = ((next_mover_mark == :x) ? :o : :x)
          new_node = TicTacToeNode.new(new_board, new_mark, [i, j])
          next_nodes << new_node
        end
      end
    end

    next_nodes
  end

end

# b = Board.new
# b[[1,1]] = :o
# b[[0,0]] = :o
#
#
# tic = TicTacToeNode.new(b, :o, [1,1])
#
# p tic.winning_node?(:x)
# p tic.losing_node?(:x)
