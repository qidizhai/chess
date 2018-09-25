module Slideable

  def horizontal_dirs
    HORIZAINTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    result = []
    original_pos = @pos.dup
    move_dirs.each_with_index do |pos1, idx|
      while true
        updated_x, updated_y = original_pos[0] + pos1[0], original_pos[1] + pos1[1]
        if @board.valid_pos?([updated_x,updated_y]) && @board[[updated_x,updated_y]].is_a?(NullPiece)
          debugger
          result << [updated_x, updated_y]
        elsif @board.valid_pos?([updated_x,updated_y]) && (@board[[updated_x,updated_y]].color != self.color)
          result << [updated_x, updated_y]
          break
        else
          original_pos = @pos
          break
        end
        original_pos[0], original_pos[1] = updated_x, updated_y
      end
    end
    result
  end



  HORIZAINTAL_DIRS = [
    [0, -1],[0, 1],
    [-1, 0],[1, 0]
  ].freeze
  DIAGONAL_DIRS = [
    [1, 1],[-1, -1],
    [1, -1],[-1, 1]
  ].freeze

  def move_dirs

  end

end
