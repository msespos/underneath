import React from "react"
import PropTypes from "prop-types"

class Hud extends React.Component {
  render () {
    var hud_items = []
    if (this.props.active_piece) {
      hud_items.push(<div className="float-left w-40 please-move">Your Turn!</div>)
    } else {
      hud_items.push(<div className="float-left w-40 please-wait">Waiting for other player</div>)
    }

    if (this.props.humans_bombs) {
      hud_items.push(<div className="float-left w-16">
          <img className="float-left"
               src="/img/bomb.png" height="32" width="32" />
          <div className="float-left bomb-count mt-1.5">
            {this.props.humans_bombs}
          </div>
      </div>)
    }

    if (this.props.humans_messages) {
      hud_items.push(<div className="float-left w-40 game-message">
        {this.props.humans_message}
      </div>)
    }

    return (
      <div className="hud w-96 h-96 mt-4 flow-root">
      {hud_items}
      </div>
    );
  }
}

Hud.propTypes = {
};
export default Hud
