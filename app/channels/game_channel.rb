class GameChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    @game = Game.find_by(params[:id])
    stream_for @game
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def received(data)
    GameChannel.broadcast_to(@game, {
      game: @game,
      humans: @game.humans
    })
  end
end
