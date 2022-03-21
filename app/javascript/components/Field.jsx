import React from "react"
import PropTypes from "prop-types"
import actionCable from 'actioncable'

import Board from "./Board"
import Entities from "./Entities"
import TurnStrip from "./TurnStrip"

// submit move to server
const tempMove = () => {
  console.log("clicked Move!");
  const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");
  const body = JSON.stringify({'detail': 'the move, in some format'});
  fetch('/games/1/move', {
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
      entities: props.entities
    };

    const ref = this;
    App.cable.subscriptions.create({channel: "GameChannel", id: "1"}, 
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
    console.log(this.state);
  	return (
  		<div>
  			<Entities details={this.state.entities}/>
  			<Board />
        <TurnStrip turn={this.state.game.turn} 
                   phase={this.state.game.phase} />
        <div>
          <button onClick={tempMove}>Move!</button>
        </div>
  		</div>
  	);
  }
}

Field.propTypes = {
};
export default Field
