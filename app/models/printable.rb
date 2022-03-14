module Printable
  def print_state
    board = Array.new(Game::BOARD_SIZE) { Array.new(Game::BOARD_SIZE) { '-' } }
    (humans + cards + [worm]).each do |item|
      board[item.y_position][item.x_position] = item.print_label
    end
    puts board.reverse.map { |e| e.join(' ') }
  end
end
