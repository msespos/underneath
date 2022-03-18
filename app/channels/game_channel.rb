class GameChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    @game = Game.find(params[:id])
    stream_for @game
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # TODO: instead of sending separate moves...
  #  Should instead transmit turns over the WebSocket
  def received(data)
    # GameChannel.broadcast_to(@game, {
    #   game: @game,
    #   humans: @game.humans
    # })
  end
end
