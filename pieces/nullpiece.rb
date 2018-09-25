require 'singleton'
require_relative 'piece.rb'

class NullPiece < Piece
  attr_accessor :symbol
  include Singleton

  def initialize
    @color = nil
    @symbol = " "
  end

  def moves
    []
  end

end
