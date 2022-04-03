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
      @state = @game.worm_view_state
    end
    # @valid_moves = current_valid_moves
    # @active = current_active_piece
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

    piece = current_active_piece
    piece.x_position += params[:delta_x]
    piece.y_position += params[:delta_y]
    piece.save!

    @game.advance_phase
    @game.save!

    broadcast!
    render :json => { :success => 1 }
  end

  private

  # TODO: need two versions of this, one for each side
  def broadcast!
    Rails.logger.info("Broadcasting: #{@game.id} #{@game.turn}")

    GameChannel.broadcast_to("game:#{@game.to_gid_param}:human", 
      {game: @game}.merge(@game.humans_view_state))

    GameChannel.broadcast_to("game:#{@game.to_gid_param}:worm", 
      {game: @game}.merge(@game.worm_view_state))

    # GameChannel.broadcast_to("game:#{game.to_gid_param}:worm", @game.human_view_state)

    # GameChannel.broadcast_to(@game, {
    #   game: @game,
    #   entities: {humans: @game.humans,
    #              worm: @game.worm,
    #              cards: @game.cards},

    #   # TODO: only send if permitted
    #   active: current_active_piece, 
    #   valid_moves: current_valid_moves 
    # })
  end

  def current_active_piece
    phase, phase_index = @game.phase.split(' ')
    if phase == 'human'
      @game.humans.detect { |p| p.play_order == phase_index.to_i }
    elsif phase == 'worm'
      @game.worm
    end
  end

  def current_valid_moves
    current_active_piece.reload.valid_moves
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
    elsif @game.worm=_player_id == @player_id
      'worm'
    end
  end

end
