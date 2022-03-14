import React from "react"
import PropTypes from "prop-types"

function renderSquare(i, j, per_row, side, parity) {
  const width_percent = 100/per_row + '%'
  return (
    <div key={'square_' + i + '_' + j}
         className={'board_square float-left text-center align-middle ' + side + '_' + parity}
         style={{width: width_percent,
                 height: width_percent}}>
    
    </div>
    )
}

class Board extends React.Component {
  render () {
    const squares = [];
    for (var i = 0; i < 8; i++) {
      for (var j = 0; j < 8; j++) {
        squares.push(
            renderSquare(i, j, 8,
                         'human', 
                         (i + j) % 2))
      }
    }
    return (
      <div className="w-96 h-96 flow-root">
        {squares}
      </div>
    );
  }
}

Board.propTypes = {
};
export default Board
