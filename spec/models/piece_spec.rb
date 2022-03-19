require 'rails_helper'

RSpec.describe Piece, type: :model do
  subject(:human) { Human.new(x_position: 3, y_position: 3) }
  describe '#start_and_finish_on_board?' do
    context "when the piece starts and finishes on the board" do
      it 'returns true' do
        start_and_finish = human.send(:start_and_finish_on_board?, [0, 2])
        expect(start_and_finish).to eq(true)
      end
    end
  end
end