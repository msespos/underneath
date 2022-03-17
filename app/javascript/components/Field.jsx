import React from "react"
import PropTypes from "prop-types"
import actionCable from 'actioncable'

import Board from "./Board"
import Humans from "./Humans"
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
      humanPieces: props.humanPieces
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
        ref.setState({
          game: data.game,
          humanPieces: data.humans
        });
      }
    });

  }

  render () {
    console.log(this.state);
  	return (
  		<div>
  			<Humans pieces={this.state.humanPieces}/>
  			<Board />
        <TurnStrip turn={this.state.game.turn}/>
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
