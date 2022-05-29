import React from "react"
import PropTypes from "prop-types"

function renderEntity(type, index, piece, per_row) {
  // offset calculates how to center the piece
  //  Pieces are 32px square
  //  Assume rem=16px
  // hard-coding per_row to 8 for the moment
  const x = piece['x_position'];
  const y = piece['y_position'];
  if (x == null) {
    return '';  // undefined coords = off board
  }
  const squareSize = 16*96/(4*per_row);
  const pieceOffset = (squareSize - 32)/2/(96*16/4);

  const top = (100 * (y/per_row + pieceOffset)) + '%';
  const left = (100 * (x/per_row + pieceOffset)) + '%';

  return (
    <div key={type + '_' + index}
         className={'entity ' + type + ' ' + type + '_' + index}
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

    var i = 0;
    if (this.props.face_down_cards) {
      this.props.face_down_cards.forEach(piece => {
        output.push(
          renderEntity('card', i, piece, 8)
        );
        i = i + 1;
      });
    }

    if (this.props.face_up_cards || this.props.rocks) {
      var rocks = (this.props.face_up_cards || []);
      if (this.props.rocks) {
        rocks = rocks.concat(this.props.rocks);
      }
      i = 0;
      rocks.forEach(piece => {
        output.push(
          renderEntity('rock', i, piece, 8)
        );
        i = i + 1;
      });
    }

    if (this.props.active_bombs) {
      i = 0;
      this.props.active_bombs.forEach(piece => {
        output.push(
          renderEntity('active_bomb', i, piece, 8)
        );
        i = i + 1;
      });
    }

    if (this.props.humans) {
      // we have to have a consistent order so animations to work!
      // otherwise, the items reorder in the DOM, breaking animations
      var humans = this.props.humans.sort((a, b) => a['play_order'] - b['play_order']);
      humans.forEach(piece => {
        output.push(
          renderEntity('human', piece['play_order'], piece, 8, 'jitter')
        );
      });
    }

    if (this.props.worm) {
      const worm = this.props.worm;
      output.push(
        renderEntity('worm', 1, worm, 8)
      );
    } 

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
