require 'rails_helper'

RSpec.describe Game, type: :model do
  subject(:game) { Game.new(id: 1) }
  describe '#set_up' do
    context 'when set_up is run three times' do
      it 'creates exactly four humans' do
        game.set_up
        game.set_up
        game.set_up
        number_of_humans = game.humans.count
        expect(number_of_humans).to eq(4)
      end
    end
    context 'when set_up is run three times' do
      it 'creates exactly 45 cards' do
        game.set_up
        game.set_up
        game.set_up
        number_of_cards = game.cards.count
        expect(number_of_cards).to eq(45)
      end
    end
  end
  describe '#set_up_humans' do
    context 'when set_up_humans is run' do
      it 'creates a human with play order 1 and x position 0' do
        game.save
        game.set_up_humans
        first_human = game.humans.first
        first_humans_x_position = first_human.x_position
        expect(first_humans_x_position).to eq(0)
      end
    end
    context 'when set_up_humans is run' do
      it 'creates a human with play order 2 and y position 3' do
        game.save
        game.set_up_humans
        second_human = game.humans.second
        second_humans_y_position = second_human.y_position
        expect(second_humans_y_position).to eq(3)
      end
    end
    context 'when set_up_humans is run' do
      it 'creates a human with play order 3 who is alive' do
        game.save
        game.set_up_humans
        third_human = game.humans.third
        third_humans_aliveness = third_human.alive
        expect(third_humans_aliveness).to eq(true)
      end
    end
  end
  describe '#set_up_worm' do
    context 'when set_up_worm is run' do
      it 'creates a worm with x position 7' do
        game.save
        game.set_up_worm
        worm = game.worm
        worms_x_position = worm.x_position
        expect(worms_x_position).to eq(7)
      end
    end
    context 'when set_up_worm is run' do
      it 'creates a worm that is alive' do
        game.save
        game.set_up_worm
        worm = game.worm
        worms_aliveness = worm.alive
        expect(worms_aliveness).to eq(true)
      end
    end
  end
  describe '#set_up_cards' do
    context 'when set_up_cards is run' do
      it 'creates a first card with x position 0' do
        game.save
        game.set_up_cards
        first_card = game.cards.first
        first_cards_x_position = first_card.x_position
        expect(first_cards_x_position).to eq(0)
      end
    end
    context 'when set_up_cards is run' do
      it 'creates a second card that is face down' do
        game.save
        game.set_up_cards
        second_card = game.cards.second
        second_cards_face_status = second_card.face_up
        expect(second_cards_face_status).to eq(false)
      end
    end
    context 'when set_up_cards is run' do
      it 'creates a total of 21 Rock cards' do
        game.save
        game.set_up_cards
        number_of_rock_cards = game.cards.where(type: 'Rock').count
        expect(number_of_rock_cards).to eq(21)
      end
    end
  end
end
