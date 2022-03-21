require 'securerandom'

class GamesController < ApplicationController
  before_action :require_cookie
  def index
    # TODO: show _my_ {open + recently finished} games
    @games = Game.all.order('created_at DESC')
  end

  def show
    # TODO: assign me a game, and show that one only
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new
    if params[:side] == 'human'
      @game.human_player_id = cookies['player_id']
    elsif params[:side] == 'worm'
      @game.worm_player_id = cookies['player_id']
    end
    @game.save!
    @game.set_up

    redirect_to @game
  end

  # temporary function for proof of concept
  def move
    @game = Game.find(params[:game_id])
    if @game.humans.any?
      human = @game.humans.first
      human.x_position = rand(8)
      human.y_position = rand(8)
      human.save!
    end
    if @game.turn
      @game.turn += 1
      @game.save!
    end
    # Rails.logger.info("Broadcasting #{@game} #{@game.turn}")
    GameChannel.broadcast_to(@game, {
      game: @game,
      entities: {humans: @game.humans,
                 worm: @game.worm,
                 cards: @game.cards} 
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
