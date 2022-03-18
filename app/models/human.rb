class Human < Piece
  belongs_to :game

  def print_label
    'H'
  end

  def valid_move?(v)
    start_and_finish_on_board?(v) && kings_move?(v) && number_of_squares_away(v) == 1
  end

  def kings_move?(v)
    v[0] == 0 && [-1, 1].include?(v[1]) || v[1] == 0 && [-1, 1].include?(v[0]) ||
    [-1, 1].include?(v[0]) && v[0].abs == v[1].abs
  end
end
