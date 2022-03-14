class GamesController < ApplicationController

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
    Rails.logger.info("Server moving #{params}")
    @game = Game.find(1)
    if @game.humans.any?
      human = @game.humans.first
      human.x_position = rand(8) + 1
      human.y_position = rand(8) + 1
      human.save!
    end
    GameChannel.broadcast_to(@game, {
      game: @game,
      humans: @game.humans
    })
    Rails.logger.info("Finished move!")
    render :json => { :success => 1 }
  end

end
