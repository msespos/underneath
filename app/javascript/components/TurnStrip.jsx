import React from "react"
import PropTypes from "prop-types"

function scrollToTurn(ref, turn) {
    var target_scroll = 1 + 24 + (turn - 1) * 48;
    ref.current.scroll({left: target_scroll, behavior: 'smooth'});
}

class TurnStrip extends React.Component {
  constructor(props) {
    super(props);
    this.ref = React.createRef();
  }
  render () {
    const turnIndicators = [];
    // spacers
    for (var i = 0; i < 4; i++) {
      turnIndicators.push(
        <div key={"spacer_" + i}
             className="w-12 flex-none text-center">&nbsp;</div>
      )      
    }
    // actual numbers
    for (var i = 1; i < 99; i++) {
      var addnlClass = '';
      if (this.props.next_worm_emergence_turn == i) {
        addnlClass = 'next-emergence';
      }

      turnIndicators.push(
        <div key={"turn_indicator_" + i}
             className={"w-12 flex-none text-center " + addnlClass}>{i}</div>
      )
    }
    // 96/2 - 7/2 = 89/2 = 89/8 rem
    return (
      <div className="turn-strip h-10 pt-2">
        <div className="h-7">
          <div className="flex w-96 overflow-hidden"
               style={{position: "absolute"}}>
            <div className="turn-strip-l-mask w-48 h-7"
                 style={{position: 'absolute', left: 0}} />
            <div className="turn-strip-r-mask w-48 h-7"
                 style={{position: 'absolute', right: 0}} />
            <div className="turn-strip-cursor w-6 h-6" 
                 style={{position: 'absolute', left: '11.175rem'}} />
            <div className="flex flex-no-wrap w-96 custom-horiz-scroll overflow-hidden"
                 ref={this.ref}>
              {turnIndicators}
            </div>
          </div>
        </div>
        <div className="text-xs h-2 text-center">
          {this.props.phase}
        </div>
      </div>
    );
  }
  componentDidMount () {
    scrollToTurn(this.ref, this.props.turn);
  }
  componentDidUpdate () {
    scrollToTurn(this.ref, this.props.turn);
  }
}

TurnStrip.propTypes = {
};
export default TurnStrip
