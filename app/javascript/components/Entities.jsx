import React from "react"
import PropTypes from "prop-types"

function renderEntity(type, index, x, y, per_row) {
  // offset calculates how to center the piece
  //  Pieces are 32px square
  //  Assume rem=16px
  // hard-coding per_row to 8 for the moment
  const squareSize = 16*96/(4*per_row);
  const pieceOffset = (squareSize - 32)/2/(96*16/4);

  const top = (100 * (x/per_row + pieceOffset)) + '%';
  const left = (100 * (y/per_row + pieceOffset)) + '%';
  return (
    <div key={type + '_' + index}
         className={type}
         style={{position: 'absolute',
                 top: top,
                 left: left}}>
      <img src={'/img/' + type + '.png'} 
           height="32" width="32" />
    </div>
    )
}

class Entities extends React.Component {
  render () {
    const output = [];
    this.props.details.humans.forEach(piece => {
      output.push(
        renderEntity('human',
          piece['play_order'],
          piece['x_position'],
          piece['y_position'],
          8)
      );
    });
    const worm = this.props.details.worm;
    output.push(
      renderEntity('worm',
        worm['play_order'],
        worm['x_position'],
        worm['y_position'],
        8)
    );
    this.props.details.cards.forEach(piece => {
      output.push(
        renderEntity('card',
          piece['play_order'],
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

Entities.propTypes = {
};
export default Entities
