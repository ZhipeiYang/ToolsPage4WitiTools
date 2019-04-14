import 'package:flutter/material.dart';
import 'package:tools_page/Tips/new_connection.dart';
class ToolsPage extends StatefulWidget {
  final Widget child;

  ToolsPage({Key key, this.child}) : super(key: key);

  _ToolsPageState createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测速'),
        actions: <Widget> [
          PopupMenuButton<String>(
            onSelected: (String value) {
              print(value);
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                value: '新建',
                child: Text('新建')
              ),
              PopupMenuItem<String>(
                value: '选择',
                child: Text('选择')
              )
            ]
          )
        ]
      ),
      body: NewConnection(),
    );
  }
}