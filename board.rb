require_relative 'pieces'



class Board
  attr_accessor :rows, :sentinel

  def initialize
    @sentinel = NullPiece.instance
    @rows = Array.new(8){Array.new(8)}
    populate_initial
  end

  def [](pos)
    x,y = pos
    @rows[x][y]
  end

  def []=(pos,val)
    x,y = pos
    @rows[x][y] = val
  end

  def move_piece(color = nil, start_pos, end_pos)
    raise "There is no piece at #{start_pos}" if @rows[start_pos].to_a?(NullPiece)
    raise "The piece can't move to #{end_pos}" unless valid_pos?(end_pos)
    move_piece!(color, start_pos, end_pos)
  end

  def populate_initial
    piece_non_pawn = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    [:white, :black].each do |color|
      piece_non_pawn.each_with_index do |pie, idx|
        if color == :white
          self[[0, idx]] = pie.new(:white, self, [0, idx])
        else
          self[[7, idx]] = pie.new(:black, self, [7, idx])
        end
      end
      8.times do |num|
        if color == :white
          self[[1, num]] = Pawn.new(:white, self, [1, num])
        else
          self[[6, num]] = Pawn.new(:black, self, [6, num])
        end
      end
    end

    (2..5).each do |row|
      8.times do |col|
        self[[row,col]] = @sentinel
      end
    end
  end

  def valid_pos?(pos)
    x,y = pos
    if x < 0 || x > 7 || y < 0 || y > 7
      return false
    end
    return true
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def checkmate?(color)
    return false unless in_check?(color)

    pieces.select { |p| p.color == color }.all? do |piece|
      piece.valid_moves.empty?
    end
  end

  def in_check?(color)
    king_pos = find_king(color).pos
    pieces.any? do |p|
      p.color != color && p.moves.include?(king_pos)
    end
  end

  def find_king(color)
    king_pos = pieces.find { |p| p.color == color && p.is_a?(King) }
    king_pos || (raise 'king not found?')
  end

  def pieces
    @rows.flatten.reject(&:empty?)
  end

  def empty?(pos)
    self[pos].empty?
  end

  def dup
  end

  def move_piece!(color, start_pos, end_pos)
    rows[end_pos] = rows[start_pos]
    rows[start_pos] = sentinel
  end
end
