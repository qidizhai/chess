module Stepable
  def moves
    result = []
    original_pos = @pos.dup
    move_diffs.each do |pos1|
      updated_x, updated_y = original_pos[0] + pos1[0], original_pos[1] + pos1[1]
      if @board.valid_pos?([updated_x,updated_y]) && @board[[updated_x,updated_y]].is_a?(NullPiece)
        result << [updated_x, updated_y]
      elsif @board.valid_pos?([updated_x,updated_y]) && (@board[[updated_x,updated_y]].color != self.color)
        result << [updated_x, updated_y]
      end
      original_pos = @pos
    end
  end
end
