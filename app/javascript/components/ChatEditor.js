import React from "react";
import { Editor } from "@tinymce/tinymce-react";

class ChatEditor extends React.Component {
  render(){
  return (
    <Editor
      apiKey="9loq66jpuhdhxhjfc6znweyyys5dgxwd6yw61gc0732rb94e"
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
