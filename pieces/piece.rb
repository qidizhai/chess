require_relative "slideable.rb"
require_relative "stepable.rb"
require "singleton"

class Piece
   attr_accessor :color, :board, :pos

   def initialize(color, board, pos)
     @color = color
     @board = board
     @pos = pos
     @board.add_piece(self, pos)
   end

   def to_s
    " #{symbol} "
   end

   def empty?
     self.is_a?(NullPiece) ? true : false
   end

   def valid_moves
    moves.reject { |end_pos| move_into_check?(end_pos) }
   end

   def move_into_check?(end_pos)
    test_board = board.dup
    test_board.move_piece!(pos, end_pos)
    test_board.in_check?(color)
   end

end
