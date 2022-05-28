import React from "react"
import PropTypes from "prop-types"
import actionCable from 'actioncable'

import Board from "./Board"
import Entities from "./Entities"
import Controls from "./Controls"
import TurnStrip from "./TurnStrip"
import Hud from "./Hud"

class Field extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      game: props.game,
      worm: props.worm,
      humans: props.humans,
      humans_left: props.humans_left,
      face_up_cards: props.face_up_cards,
      face_down_cards: props.face_down_cards,
      rocks: props.rocks,
      active_bombs: props.active_bombs,
      active_piece: props.active_piece,
      valid_moves: props.valid_moves,
      valid_bomb_placements: props.valid_bomb_placements
    };

    const ref = this;
    App.cable.subscriptions.create({channel: "GameChannel", id: props.game.id}, 
    {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log("Connected to the game (view): ", this);
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log("Received some data: ", data);
        ref.setState(data);
      }
    });

  }

  render () {
  	return (
  		<div>
  			<Entities worm={this.state.worm}
                  humans={this.state.humans}
                  rocks={this.state.rocks}
                  face_down_cards={this.state.face_down_cards}
                  face_up_cards={this.state.face_up_cards}
                  active_bombs={this.state.active_bombs} />
        <Controls gameId={this.state.game.id} 
                  active_piece={this.state.active_piece}
                  valid_moves={this.state.valid_moves}
                  valid_bomb_placements={this.state.valid_bomb_placements} />
  			<Board />
        <TurnStrip turn={this.state.game.turn} 
                   phase={this.state.game.phase} />
        <Hud active_piece={this.state.active_piece} 
             humans_bombs={this.state.game.humans_bombs} 
             humans_left={this.state.humans_left} 
             humans_message={this.state.humans_message} />
  		</div>
  	);
  }
}

Field.propTypes = {
};
export default Field
