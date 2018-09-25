# require piece
class Pawn < Piece
  def symbol
    '♟'.colorize(color)
  end

  def move_dirs
    forward_steps + side_attacks
  end

  def moves
    forward_steps + side_attacks
  end

  private
  def at_start_row?
    x_pos, y_pos = @pos
    if self.color == :black
      return true if x_pos == 6
    elsif self.color == :white
      return true if x_pos == 1
    end
    return false
  end

  def forward_dir
     color == :white ? -1 : 1
  end

  def forward_steps
    result = []
    x_pos, y_pos = @pos
    if at_start_row?
      if @board[[x_pos,y_pos+1]].is_a?(NullPiece)
        result << [x_pos, y_pos+1]
        if @board[[x_pos,y_pos+2]].is_a?(NullPiece)
          result << [x_pos, y_pos+2]
        end
      end
    else
      if @board[[x_pos,y_pos+1]].is_a?(NullPiece)
        result << [x_pos, y_pos+1]
      end
    end
    result
  end

  def side_attacks
    i, j = pos

    side_moves = [[i + forward_dir, j - 1], [i + forward_dir, j + 1]]

    side_moves.select do |new_pos|
      next false unless board.valid_pos?(new_pos)
      next false if board.empty?(new_pos)

      threatened_piece = board[new_pos]
      threatened_piece && threatened_piece.color != color
    end
  end
end
