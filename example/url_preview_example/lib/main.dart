import 'package:flutter/material.dart';
import 'package:url_preview_example/screens/home.dart';

void main() => runApp(UrlPreviewExample());

class UrlPreviewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Url Preview Example', home: ChatScreen());
  }
}
