import 'package:flutter/material.dart';
import 'package:url_preview_example/models/message.dart';
import 'package:url_preview_example/package/url_preview.dart';

void main() => runApp(UrlPreviewExample());

class UrlPreviewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ChatScreen());
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String message = "";
  final ScrollController listScrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();
  _buildMessage(Message message) {
    return message.type == 1
        ? Container(
            constraints: BoxConstraints(minWidth: 100, maxWidth: 250),
            margin: EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            ),
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor
                  ]),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  message.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        : UrlPreview(
            url: message.text,
            disableTapCallback: true,
          );
  }

  int _getMessageType(String message) {
    if (message?.startsWith('http://') == true ||
        message?.startsWith('https://') == true) {
      return 2;
    }
    return 1;
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: TextField(
                controller: textEditingController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message...',
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              if (textEditingController.text.length != 0) {
                messagesList.add(Message.fromMap({
                  'text': textEditingController.text,
                  'type': _getMessageType(textEditingController.text),
                }));
                textEditingController.clear();
                listScrollController.animateTo(0.0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut);
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }

  List<Message> messagesList = [
    Message.fromMap({"text": "https://test.com", "type": 2})
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          "URL Preview Example",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ClipRRect(
                  child: ListView.builder(
                    controller: listScrollController,
                    padding: EdgeInsets.only(top: 15.0),
                    itemCount: messagesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildMessage(messagesList[index]);
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
