import React from "react"
import PropTypes from "prop-types"


// submit move to server
const sendMove = (gameId, deltaX, deltaY) => {
  console.log('move ' + deltaX + ', ' + deltaY);
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
         onClick={(e) => sendMove(gameId, x - activeX, y - activeY, e)}>
    </div>
    )
}

class Controls extends React.Component {
  render () {
    const output = [];

    var i = 0;
    this.props.valid_moves.forEach(target => {
      output.push(
        renderTarget('valid_move',
          i,
          target[0],
          target[1],
          8,
          this.props.gameId,
          this.props.active.x_position,
          this.props.active.y_position)
      );
      i = i + 1;
    });

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
