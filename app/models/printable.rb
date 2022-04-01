module Printable
  def print_state
    board = Array.new(Game::BOARD_SIZE) { Array.new(Game::BOARD_SIZE) { '-' } }
    all_pieces.each do |item|
      unless item.x_position == nil || item.y_position == nil
        board[item.y_position][item.x_position] = item.print_label
      end
    end
    puts board.map { |e| e.join(' ') }
  end
end
