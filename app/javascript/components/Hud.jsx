import React from "react"
import PropTypes from "prop-types"

class Hud extends React.Component {
  render () {
    var hud_items = [];
    
    if (this.props.game_status !== "Game in play") {
      hud_items.push(<div key="hud1" className="float-left w-40 active-message">Game over!</div>)
    } else if (this.props.active_piece) {
      hud_items.push(<div key="hud1" className="float-left w-40 active-message">Your Turn!</div>)
    } else {
      hud_items.push(<div key="hud1" className="float-left w-40 idle-message">Waiting for other player</div>)
    }

    if (!isNaN(this.props.humans_bombs)) {
      hud_items.push(<div key="hud2" className="float-left w-16">
          <img className="float-left"
               src="/img/bomb.png" height="32" width="32" />
          <div className="float-left bomb-count mt-1.5">
            {this.props.humans_bombs}
          </div>
      </div>)
    }

    if (!isNaN(this.props.humans_left)) {
      hud_items.push(<div key="hud3" className="float-left w-16">
          <img className="float-left"
               src="/img/human.png" height="32" width="32" />
          <div className="float-left human-count mt-1.5">
            {this.props.humans_left}
          </div>
      </div>)
    }

    var message = this.props.humans_message || this.props.last_revealed_card_message;
    if (message) {
      hud_items.push(<div key="hud4" className="float-left w-40 game-message">
        {message}
      </div>)
    }

    if (this.props.worm_message) {
      hud_items.push(<div key="hud5" className="float-left w-40 game-message">
        {this.props.worm_message}
      </div>)
    }

    return (
      <div className="hud w-96 mt-4 flow-root">
      {hud_items}
      </div>
    );
  }
}

Hud.propTypes = {
};
export default Hud
