import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:tools_page/Class/conn.dart';
import 'package:sqflite/sqflite.dart';

class SelectConn extends StatefulWidget {
  @override
  _SelectConnState createState() => _SelectConnState();
}

class _SelectConnState extends State<SelectConn> {
  List<Map> _connList;
  bool _connListFlag = false;
  List<ConnectInfo> _connInfoList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择'),
      ),
      body: Container(child: getListView()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          initList();
          //print('初始化完成');
          // if(_connListFlag==false){
          //   Scaffold.of(context).showSnackBar(SnackBar(
          //     content: Text('数据库为空'),
          //   ));
          // }else{
          //   Scaffold.of(context).showSnackBar(SnackBar(
          //     content: Text('刷新成功'),
          //   ));
          // }
        },
      ),
    );
  }

  initList() {
    String dataBasePath;
    String path;
    ConnectInfoUtil util = ConnectInfoUtil();
    setState(() {
      _connListFlag = false;
    });
    getDatabasesPath().then((value) {
      dataBasePath = value;
      path = join(dataBasePath, 'connInfo.db');
      util.open(path).then((value2) {
        util.getAll().then((onValue) {
          if (onValue != null) {
            setState(() {
              _connList = List<Map>();
              _connList = onValue;
              _connInfoList = List<ConnectInfo>();
              for (var item in _connList) {
                ConnectInfo conn = ConnectInfo.fromMap(item);
                _connInfoList.add(conn);
              }
              _connListFlag = true;
            });
          }
          //util.close();
        });
      });
    });
  }

  getListView() {
    if (_connListFlag) {
      return ListView.builder(
        physics: new ClampingScrollPhysics(),
        itemCount: _connInfoList.length,
        itemBuilder: (BuildContext context, int position) {
          return getItem(position);
        },
      );
    } else {
      return Center(
        child: Text('请刷新'),
      );
    }
  }

  getItem(int position) {
    return Card(
      child: Row(children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _connInfoList[position].nick,
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  _connInfoList[position].host,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        PopupMenuButton<int>(
            onSelected: (int value) {
              print(value);
              if (value == 0) {
              } else if (value == 1) {
              } else if (value == 2) {
                String dataBasePath;
                String path;
                ConnectInfoUtil util = ConnectInfoUtil();
                getDatabasesPath().then((value) {
                  dataBasePath = value;
                  path = join(dataBasePath, 'connInfo.db');
                  util.open(path).then((value2) {
                    util.delete(_connInfoList[position].uuid).then((onValue) {
                      if (onValue > 0) {
                        print('delete success');
                        initList();
                      }
                    });
                    //util.close();
                  });
                });
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                  PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                              child: Icon(Icons.looks_one),),
                          Text('选择'),
                        ],
                  )),
                  PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                              child: Icon(Icons.looks_two)),
                          Text('修改'),
                        ],
                  )),
                  PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                              child: Icon(Icons.delete)),
                          Text('删除'),
                        ],
                  )),
                ])
      ]),
    );
  }
}
