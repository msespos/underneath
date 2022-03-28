import React from "react"
import PropTypes from "prop-types"

function renderTarget(type, index, x, y, per_row) {
  const size = 100/per_row + '%'  
  const top = (100 * (x/per_row)) + '%';
  const left = (100 * (y/per_row)) + '%';
  return (
    <div key={type + '_' + index}
         className={type + '_square '}
         style={{position: 'absolute',
                 top: top,
                 left: left,
                 width: size,
                 height: size}}>
    </div>
    )
}

class Controls extends React.Component {
  render () {
    const output = [];

    var i = 0;
    this.props.validMoves.forEach(target => {
      output.push(
        renderTarget('valid_move',
          i,
          target[0],
          target[1],
          8)
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
