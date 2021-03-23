import React from "react";
import PropTypes from "prop-types";

class HelloMessage extends React.Component {
  render () {
    return (
      <div>
        <h1>Hello {this.props.name}, </h1>

        <h3>Wow! This is your first react component!</h3>
      </div>
    );
  }
}

HelloMessage.propTypes = {
  name: PropTypes.string
};

export default HelloMessage;
