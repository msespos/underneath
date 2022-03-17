require 'securerandom'

class GamesController < ApplicationController
  before_action :require_cookie
  def index
    # TODO: show maybe all games?
    #  or all "open" games + games that closed
    #  in the last day or something like that 
    @games = []
    g = Game.all.last
    @games = [g] if g
  end

  def show
    # TODO: assign me a game, and show that one only
    @game = Game.find(1)
  end

  # temporary function for proof of concept
  def move
    @game = Game.find(1)
    if @game.humans.any?
      human = @game.humans.first
      human.x_position = rand(8) + 1
      human.y_position = rand(8) + 1
      human.save!
    end
    if @game.turn
      @game.turn += 1
      @game.save!
    end
    GameChannel.broadcast_to(@game, {
      game: @game,
      humans: @game.humans
    })
    render :json => { :success => 1 }
  end

  private

  def require_cookie
    unless cookies['player_id']
      cookies.permanent['player_id'] ||= SecureRandom.uuid
    end
    @player_id = cookies['player_id']
    Rails.logger.info("Player_id #{@player_id}!")
  end
end
