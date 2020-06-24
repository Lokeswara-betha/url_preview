import 'package:flutter/material.dart';
import 'package:url_preview_example/screens/chat_screen.dart';

void main() => runApp(UrlPreviewExample());

class UrlPreviewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ChatScreen());
  }
}
