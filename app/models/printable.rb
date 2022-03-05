module Printable
  def print_state
    board = Array.new(Game::BOARD_SIZE) { Array.new(Game::BOARD_SIZE) { '-' } }
    board.each_with_index do |row, y|
      row.each_with_index do |column, x|
        humans.each do |h|
          if h.x_position == x and h.y_position == y
            board[y][x] = 'H'
          end
        end
        cards.each do |c|
          if c.x_position == x and c.y_position == y
            board[y][x] = 'C'
          end
        end
        if worm.x_position == x and worm.y_position == y
          board[y][x] = 'W'
        end
      end
    end
    puts board.reverse.map { |e| e.join(' ') }
  end
end
