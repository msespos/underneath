module Printable
  def print_state
    board = Array.new(Game::BOARD_SIZE) { Array.new(Game::BOARD_SIZE) { '-' } }
    board.each_with_index do |row, y|
      row.each_with_index do |column, x|
        (humans + cards + [worm]).each do |item|
          place_item(board, item, x, y)
        end
      end
    end
    puts board.reverse.map { |e| e.join(' ') }
  end

  def place_item(board, item, x, y)
    board[y][x] = item.print_label if item.x_position == x and item.y_position == y
  end
end
