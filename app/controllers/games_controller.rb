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
    @game = Game.find(1)
  end

end
