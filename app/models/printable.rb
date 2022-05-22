module Printable
  def pall
    print(all_pieces, :humans)
  end

  def procks
    print(rocks, :worm)
  end
  
  def print(tokens, view)
    board = Array.new(Game::BOARD_SIZE) { Array.new(Game::BOARD_SIZE) { '-' } }
    tokens.each do |item|
      unless item.x_position == nil || item.y_position == nil
        board[item.y_position][item.x_position] = item.print_label(view)
      end
    end
    puts board.map { |e| e.join(' ') }
  end
end