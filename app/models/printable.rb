module Printable
  def print_state
    board = Array.new(8) { Array.new(8) { '-' } }
    board.each_with_index do |column, i|
      column.each_with_index do |row, j|
        humans.each do |h|
          if h.x_position == i and h.y_position == j
            board[j][i] = 'H'
          end
        end
        cards.each do |c|
          if c.x_position == i and c.y_position == j
            board[j][i] = 'C'
          end
        end
        if worm.x_position == i and worm.y_position == j
          board[j][i] = 'W'
        end
      end
    end
    puts board.reverse.map { |e| e.join(' ') }
  end
end
