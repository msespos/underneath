import React from "react"
import PropTypes from "prop-types"

function renderHuman(index, x, y, per_row) {
  // TODO: 0.2/0.3 is a little hackish to account for 
  //  height/width of the actual playing piece.
  //  Make this measurement more precise!
  const top = (100 * (x-1 + 0.25)/per_row) + '%';
  const left = (100 * (y - 1 + 0.33)/per_row) + '%';
  return (
    <div key={'human_' + index}
         className='human'
         style={{position: 'absolute',
                 top: top,
                 left: left}}>
    🚶
    </div>
    )
}

class Humans extends React.Component {
  render () {
    const output = [];
    this.props.pieces.forEach(piece => {
      output.push(
        renderHuman(piece['index'],
          piece['position_x'],
          piece['position_y'],
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
