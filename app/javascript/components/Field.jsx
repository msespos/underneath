import React from "react"
import PropTypes from "prop-types"
import Board from "./Board"
import Humans from "./Humans"

class Field extends React.Component {
  render () {
  	return (
  		<div>
  			<Humans />
  			<Board />
  		</div>
  	);
  }
}

Field.propTypes = {
};
export default Field
