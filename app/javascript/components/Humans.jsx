import React from "react"
import PropTypes from "prop-types"

// offset calculates how to center the piece
//  Pieces are 32px square
//  Assume rem=16px
const squareSize = 16*96/(4*per_row);
const pieceOffset = (squareSize - 32)/2/(96*16/4);

function renderHuman(index, x, y, per_row) {
  const top = (100 * (x/per_row + pieceOffset)) + '%';
  const left = (100 * (y/per_row + pieceOffset)) + '%';
  return (
    <div key={'human_' + index}
         className='human'
         style={{position: 'absolute',
                 top: top,
                 left: left}}>
      <img src="/img/human.png" height="32" width="32" />
    </div>
    )
}

class Humans extends React.Component {
  render () {
    const output = [];
    this.props.pieces.forEach(piece => {
      output.push(
        renderHuman(piece['play_order'],
          piece['x_position'],
          piece['y_position'],
          8)
      );
    });
    return (
      <div className="w-96 h-96 flow-root"
           style={{position: 'absolute'}}>
        {output}
      </div>
    );
  }
}

Humans.propTypes = {
};
export default Humans
