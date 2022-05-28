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

var directionNames = {};
directionNames[0] = {};
directionNames[-1] = {};
directionNames[1] = {};
directionNames[0][-1]  = 'w';
directionNames[0][+1]  = 'e';
directionNames[-1][0]  = 'n';
directionNames[+1][0]  = 's';
directionNames[-1][-1] = 'nw';
directionNames[-1][+1] = 'ne';
directionNames[+1][+1] = 'se';
directionNames[+1][-1] = 'sw';

// submit move to server
const sendPlay = (gameId, type, deltaX, deltaY) => {
  const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");
  const body = JSON.stringify({'type': type,
                               'delta_x': deltaX,
                               'delta_y': deltaY});
  fetch('/games/' + gameId + '/play', {
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
    <div key="active_halo"
         className="active_halo"
         style={{position: 'absolute',
                 top: top,
                 left: left,
                 width: size,
                 height: size}} />)
}

function renderMoveTarget(type, index, x, y, perRow, gameId, activeX, activeY) {
  const size = 100/perRow + '%'  
  const top = (100 * (x/perRow)) + '%';
  const left = (100 * (y/perRow)) + '%';

  const dx = x-activeX;
  const dy = y-activeY;

  const arrow = arrows[Math.sign(dx)][Math.sign(dy)];
  const direction = directionNames[Math.sign(dx)][Math.sign(dy)];
  return (
    <div key={type + '_' + index}
         className={type + '_square ' + direction}
         viewBox="0 0 10 10"
         style={{position: 'absolute',
                 top: top,
                 left: left,
                 width: size,
                 height: size}}
         onClick={(e) => sendPlay(gameId, 'move', dx, dy, e)}>
      <div className="text">{arrow}</div>
    </div>
    )
}

function renderBombTarget(type, index, x, y, perRow, gameId, activeX, activeY) {
  const size = 100/perRow + '%'  
  const top = (100 * (x/perRow)) + '%';
  const left = (100 * (y/perRow)) + '%';

  const dx = x-activeX;
  const dy = y-activeY;

  const direction = directionNames[Math.sign(dx)][Math.sign(dy)];
  return (
    <div key={type + '_' + index}
         className={type + '_square ' + direction}
         viewBox="0 0 10 10"
         style={{position: 'absolute',
                 top: top,
                 left: left,
                 width: size,
                 height: size}}
         onClick={(e) => sendPlay(gameId, 'place bomb', dx, dy, e)}>
         <img className="potential_bomb" 
              src="/img/active_bomb.png"
              height="16"
              width="16" />
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
          renderMoveTarget('valid_move',
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

    if (this.props.valid_bomb_placements) {
      var i = 0;
      var sx = this.props.active_piece.x_position;
      var sy = this.props.active_piece.y_position;
      this.props.valid_bomb_placements.forEach(target => {
        output.push(
          renderBombTarget('valid_bomb_placement',
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
    } else {
      console.log("Can't find bomb_placements here:");
      console.log(this.props);
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
