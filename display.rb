require 'colorize'
require_relative 'cursor.rb'

class Display
  attr_accessor :cursor

  def initialize(board = Board.new)

    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def play
    8.times do
      render
      @cursor.get_input
    end
  end

  def render
    system("clear")
    i = 0
    while (i < @board.rows.length)
      j = 0
      while (j < @board.rows.length)

        symbol = @board[[i,j]].symbol
        if [i,j] == @cursor.cursor_pos
          print(" #{symbol} ".colorize({background: :red}))
        else
          print(" #{symbol} ".colorize({background: :grey})) if (i.even? && j.even?) || (i.odd? && j.odd?)
          print(" #{symbol} ".colorize({background: :yellow})) if (i.odd? && j.even?) || (i.even? && j.odd?)
        end
        j += 1
      end
      print("\n")
      i += 1
    end
  end
end
