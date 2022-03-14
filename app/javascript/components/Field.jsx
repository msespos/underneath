import React from "react"
import PropTypes from "prop-types"
import Board from "./Board"
import Humans from "./Humans"

const humanPieces = [{
  'index': 1, 
  'position_x': 7,
  'position_y': 3
}, {
  'index': 2,
  'position_x': 2,
  'position_y': 6
}, {
  'index': 3,
  'position_x': 8,
  'position_y': 4
}];

class Field extends React.Component {
  render () {
  	return (
  		<div>
  			<Humans pieces={humanPieces}/>
  			<Board />
  		</div>
  	);
  }
}

Field.propTypes = {
};
export default Field
