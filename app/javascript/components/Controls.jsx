import React from "react"
import PropTypes from "prop-types"


var arrows = {};
arrows[0] = {};
arrows[-1] = {};
arrows[1] = {};
arrows[0][-1]  = '←';
arrows[0][+1]  = '→';
arrows[-1][0]  = '↑';
arrows[+1][0]  = '↓';
arrows[-1][-1] = '↖';
arrows[-1][+1] = '↗';
arrows[+1][+1] = '↘';
arrows[+1][-1] = '↙';

// submit move to server
const sendMove = (gameId, deltaX, deltaY) => {
  const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");
  const body = JSON.stringify({'delta_x': deltaX,
                               'delta_y': deltaY});
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


function renderActiveHalo(x, y, perRow) {
  const size = 100/perRow + '%';
  const top = (100 * (x/perRow)) + '%';
  const left = (100 * (y/perRow)) + '%';
  return (
    <div className="active_halo"
         style={{position: 'absolute',
                 top: top,
                 left: left,
                 width: size,
                 height: size}} />)
}

function renderTarget(type, index, x, y, perRow, gameId, activeX, activeY) {
  const size = 100/perRow + '%'  
  const top = (100 * (x/perRow)) + '%';
  const left = (100 * (y/perRow)) + '%';

  return (
    <div key={type + '_' + index}
         className={type + '_square '}
         style={{position: 'absolute',
                 top: top,
                 left: left,
                 width: size,
                 height: size}}
         onClick={(e) => sendMove(gameId, x-activeX, y-activeY, e)}>
    </div>
    )
}

class Controls extends React.Component {
  render () {
    const output = [];

    if (this.props.active_piece) {
      output.push(
        renderActiveHalo(
          this.props.active_piece.x_position,
          this.props.active_piece.y_position,
          8
        )
      );
    }
    if (this.props.valid_moves) {
      var i = 0;
      var sx = this.props.active_piece.x_position;
      var sy = this.props.active_piece.y_position;
      this.props.valid_moves.forEach(target => {
        output.push(
          renderTarget('valid_move',
            i,
            target[0],
            target[1],
            8,
            this.props.gameId,
            this.props.active_piece.x_position,
            this.props.active_piece.y_position)
        );
        i = i + 1;
      });
    }

    return (
      <div className="w-96 h-96 flow-root"
           style={{position: 'absolute'}}>
        {output}
      </div>
    );
  }
}

Controls.propTypes = {
};
export default Controls
