import React from "react";
import { Editor } from "@tinymce/tinymce-react";

class ChatEditor extends React.Component {
  render(){
  return (
    <Editor
      // apiKey= {this.props.API_KEY}
      apiKey = {process.env.REACT_APP_TINYMCE_KEY}
      init={{
        plugins: "emoticons",
        toolbar: "emoticons",
        toolbar_location: "bottom",
        menubar: false,
        placeholder: this.props.message || 'Write here..',
        selector: 'textarea',
        setup: function(editor) {
        editor.on('NodeChange', function(e) {
          let message = document.getElementById("message_content");
          message.value = e.element.innerText
        });
       }
      }}
    />
  );
  }
}

export default ChatEditor;
