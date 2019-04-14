import 'package:flutter/material.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "测速",
        ),
        actions: <Widget>[
          new PopupMenuButton<String>(
              //这是点击弹出菜单的操作，点击对应菜单后，改变屏幕中间文本状态，将点击的菜单值赋予屏幕中间文本
              onSelected: (String value) {
              },
              //这是弹出菜单的建立，包含了两个子项，分别是增加和删除以及他们对应的值
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text('增加'),
                          new Icon(Icons.add_circle)
                        ],
                      ),
                      value: '这是增加',
                    ),
                    PopupMenuItem(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text('增加'),
                          new Icon(Icons.remove_circle)
                        ],
                      ),
                      value: '这是删除',
                    )
                  ])
          
        ],
      ),
      body: Column(),
    );
  }
}
