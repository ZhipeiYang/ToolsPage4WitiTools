import 'package:flutter/material.dart';
import 'package:tools_page/Page/toolspage.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  final Widget child;

  MyApp({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToolsPage(),
    );
  }
}