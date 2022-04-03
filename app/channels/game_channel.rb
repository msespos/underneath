class GameChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    @game = Game.find(params[:id])
    side = if @game.human_player_id == current_player_id
      'human'
    elsif @game.worm_player_id == current_player_id
      'worm'
    else
      ''
    end
    stream_from "game:#{@game.to_gid_param}:#{side}"
    # TODO: when we reconnect, rebroadcast automatically
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
