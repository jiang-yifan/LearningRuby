require_relative 'checkers_board.rb'
require_relative 'checkers_player.rb'
require_relative 'checkers_errors.rb'

require 'io/console'
require 'yaml'

class Game
  attr_accessor :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new(:red), Player.new(:white)]
    play
  end

  def play
    until board.over? players[board.turn]

        system "clear"
        puts "It is #{players[board.turn].color.to_s}\'s turn"
        puts
        board.display_jumpable_piece(players[board.turn])
        board.display
        begin
        input_char = read_char

        case input_char
        when "\r" #RETURN
          return_function
        when "\e"
          puts "Are you sure you want to exit the game? (y/n)"
          if gets.chomp == "y"
            exit
          end
        when "\e[A" #up arrow
          board.cursor.move("up")
        when "\e[B" #down
          board.cursor.move("down")
        when "\e[C" #right
          board.cursor.move("right")
        when "\e[D" #left
          board.cursor.move("left")
        when "s"
          save_game
        when "l"
          load_game
        when "\u0003"
          puts "CONTROL-C"
          exit 0
        end
      rescue MustJump
        puts "You must jump"
        retry
      rescue WrongSlidingMove
        puts "You cannot make that move"
        retry
      rescue WrongPlayerPiece => e
        puts "You can't move opponent's piece"
        retry
      rescue NoPieceThere
        puts "You can't select an empty tile"
        retry
      end
    end
    game_over
  end

  def game_over
    system "clear"
    board.display
    puts "Congratulations #{players[board.turn == 1 ? 0 : 1].color.to_s}, you have beat #{players[board.turn].color.to_s}"
  end

  def save_game
    puts "enter file_name to save to without extension"
    file_name = gets.chomp
    p board
    sleep(5)
    File.open("#{file_name}.yml", "w") {|f| f.write self.board.to_yaml}
    puts "do you want to continue? (y/n)"
    exit unless gets.chomp == 'y'
  end

  def load_game
    puts "enter file_name to load from without extension"
    file_name = gets.chomp

    self.board = File.open("#{file_name}.yml") {|f| YAML.load(f)}
  end


  def return_function
    cur_pos = board.cursor.position
    if board.cursor.selected_position.nil?
      unless board[cur_pos].nil?
        if board[cur_pos].color == players[board.turn].color
          board.cursor.selected_position = board.cursor.position.dup
          board.selected_piece(players[board.turn], cur_pos)
          board.jumpable_pieces = []
        else
          raise WrongPlayerPiece
        end
      else
        raise NoPieceThere
      end
    elsif board.cursor.selected_position == board.cursor.position
      board.cursor.selected_position = nil
      board.selected_piece_options = []
    else
      turn_end = board.move_piece(board.cursor.selected_position,
      board.cursor.position, players[board.turn])

      board.turn = board.turn == 0 ? 1 : 0 if turn_end == true #can make more jumps?
      board.selected_piece_options = []
      board.cursor.selected_position = nil
    end
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end
end

g = Game.new
