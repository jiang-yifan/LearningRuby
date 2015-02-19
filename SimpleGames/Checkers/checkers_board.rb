require_relative 'checkers_piece.rb'
require_relative 'checkers_cursor.rb'

require'colorize'
require 'byebug'

class Board
  attr_reader :grid, :color
  attr_accessor :cursor, :turn, :selected_piece_options, :jumpable_pieces

  def initialize (options = true)
    @grid = Array.new(8) {Array.new(8)}
    if options
      @cursor = Cursor.new
      @turn = 0
      place_piece
      @color = [:black, :white]
      @selected_piece_options = []
    end
  end

  def [] pos
    x, y = pos
    grid[x][y]
  end

  def []= pos, value
    x, y = pos
    grid[x][y] = value
  end

  def place_piece
    grid.each_with_index do |row, i|
      row.each_with_index do |tile,j|
        pos = i, j
        if i.even? && i < 3
          self[pos] = Piece.new(:white, [i,j], self) if j.odd?
        elsif i.odd? && i < 3
          self[pos] = Piece.new(:white, [i,j], self) if j.even?
        elsif i.odd? && i > 4
          self[pos] = Piece.new(:red, [i,j], self) if j.even?
        elsif i.even? && i > 4
          self[pos] = Piece.new(:red, [i,j], self) if j.odd?
        end
      end
    end
  end

  def display

    grid.each_with_index do |row, i|
      row.each_with_index do |tile,j|
        if tile.nil?
          saved_display = "   "
        else
          saved_display = " " + tile.symbol.colorize(tile.color) + " "
        end
        if cursor.position == [i,j]
          print saved_display.colorize(:background => :cyan)
        elsif selected_piece_options.include? [i,j]
          print saved_display.colorize(:background => :yellow)
        elsif cursor.selected_position == [i,j]
          print saved_display.colorize(:yellow)
        elsif !jumpable_pieces.include?(cursor.selected_position) &&
          jumpable_pieces.include?([i, j])
          print saved_display.colorize(:background => :green)
        elsif i.odd?
          print saved_display.colorize(:background => color[j % 2 == 0 ? 0 : 1])
        else
          print saved_display.colorize(:background => color[j % 2 == 0 ? 1 : 0])
        end
      end
      puts
    end
    puts
  end

  def valid_pos? pos
    (0..7) === pos[0] && (0..7) === pos[1]
  end

  def empty? pos
    valid_pos?(pos) && self[pos].nil?
  end


  def color_of_piece_there move
    return self[move].color
  end

  def selected_piece player, pos
    self.selected_piece_options = []
    if self[pos].color == player.color
      self.selected_piece_options = self[pos].valid_jumps
      self.selected_piece_options = self[pos].perform_slide player if selected_piece_options.empty?
    end
  end

  def move_piece selected_pos, new_pos, player
    unless valid_jump? player #any valid jumps?
      if self[selected_pos].perform_slide(player).include?(new_pos) #no then try slide
        make_move(selected_pos, new_pos, player)
        self[new_pos].king_promoted?
        true
      else
        raise WrongSlidingMove
      end
    else # do jump
      if self[selected_pos].valid_jumps.include?(new_pos) # can the jump be made?
        make_move(selected_pos, new_pos, player) # make jumps
        kill_piece(selected_pos, new_pos) # remove enemy
        current_piece = self[new_pos]
        return true if self[new_pos].king_promoted?
        return false unless current_piece.perform_jump(player).empty?
        true
      else
        raise MustJump
      end
    end
  end

  def display_jumpable_piece player
    self.jumpable_pieces = []
    if valid_jump? player
      all_player_pieces(player).select{|piece| !piece.valid_jumps.empty?}.each do |piece|
        jumpable_pieces << piece.position
      end
    end
  end

  def make_move selected_pos, new_pos, player
    self[selected_pos].position = new_pos
    self[selected_pos], self[new_pos] = self[new_pos], self[selected_pos]
  end

  def kill_piece selected_pos, new_pos
    n_x, n_y = new_pos
    s_x, s_y = selected_pos
    piece_location = [(n_x - s_x)/2 + s_x, (n_y - s_y)/2 + s_y]
    self[piece_location] = nil
  end

  def all_player_pieces player
    grid.flatten.compact.select {|piece| piece.color == player.color}
  end

  def valid_jump? player
    jumps = []
    all_player_pieces(player).each do |piece|
      jumps << piece.valid_jumps
    end
      !jumps.reject{|jump| jump.empty?}.empty?
  end

  def over? player
    moves = []
    all_player_pieces(player).each do |piece|
      moves << piece.perform_jump(player)
      moves << piece.perform_slide(player)
    end
    self.jumpable_pieces = []
    moves.reject{|move| move.empty?}.empty?
  end

end

# class Player
#   attr_reader :color
#   def initialize color
#     @color = color
#   end
# end
# p1 = Player.new :red
# p1 = Player.new :white
# # b = Board.new
#
# b.move_piece [5,2], [4,3], :red
# b.move_piece [2,1], [3,2], :white
#
# b.move_piece [4,3], [2,1], :red
# b.display
