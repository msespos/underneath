import React from "react"
import PropTypes from "prop-types"
import actionCable from 'actioncable'

import Board from "./Board"
import Entities from "./Entities"
import Controls from "./Controls"
import TurnStrip from "./TurnStrip"

// submit move to server
const tempMove = (gameId) => {
  const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");
  const body = JSON.stringify({'detail': 'the move, in some format'});
  fetch('/games/' + gameId + '/move', {
    method: 'POST',
    credentials: 'same-origin',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrf
    },
    body: body
  });
};

class Field extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      game: props.game,
      entities: props.entities,
      validMoves: props.validMoves
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
  			<Entities details={this.state.entities}/>
        <Controls validMoves={this.state.validMoves}/>
  			<Board />
        <TurnStrip turn={this.state.game.turn} 
                   phase={this.state.game.phase} />
        <div>
          <button onClick={(e) => tempMove(this.state.game.id, e)}>Move!</button>
        </div>
  		</div>
  	);
  }
}

Field.propTypes = {
};
export default Field
