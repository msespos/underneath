require 'securerandom'

class GamesController < ApplicationController
  before_action :require_cookie

  def index
    # TODO: show _my_ {open + recently finished} games
    @games = Game.all.order('created_at DESC')

    # TODO: clean this up
    @games = @games.select do |g| 
      players = [g.worm_player_id, g.human_player_id]
      (@player_id.in?(players) || nil.in?(players)) && players.any?
    end
  end

  def show
    # TODO: assign me a game, and show that one only
    @game = Game.find(params[:id])
    if player_side == "human"
      @state = @game.humans_view_state
    elsif player_side == "worm"
      @state = @game.worms_view_state
    end
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

  def join
    @game = Game.find(params[:game_id])
    if @game.human_player_id.nil?
      @game.human_player_id = @player_id
    elsif @game.worm_player_id.nil?
      @game.worm_player_id = @player_id
    else
      raise Exception.new "Can't join game #{params[:id]}"
    end
    @game.save!
    redirect_to @game
  end

  # should maybe generalize to taking a turn
  def move
    @game = Game.find(params[:game_id])

    # TODO: confirm can play this game & this side

    @game.play_turn('move',[params[:delta_x],params[:delta_y]])
    @game.reload
    
    broadcast!
    render :json => { :success => 1 }
  end

  private

  # TODO: need two versions of this, one for each side
  def broadcast!
    ActionCable.server.broadcast(
      "game:#{@game.to_gid_param}:human",
      @game.humans_view_state)

    ActionCable.server.broadcast(
      "game:#{@game.to_gid_param}:worm",
      @game.worms_view_state)
  end

  def require_cookie
    unless cookies['player_id']
      cookies.permanent['player_id'] ||= SecureRandom.uuid
    end
    @player_id = cookies['player_id']
    Rails.logger.info("Player_id #{@player_id}!")
  end

  def player_side
    if @game.human_player_id == @player_id
      'human'
    elsif @game.worm_player_id == @player_id
      'worm'
    end
  end

end
