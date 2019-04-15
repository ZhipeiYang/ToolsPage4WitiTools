import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:tools_page/Class/conn.dart';
import 'package:uuid/uuid.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

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
          body: Container(
            child: getListView()
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: (){
              initList();
              //print('初始化完成');
            },
          ),
        );  
  }

  initList() {
    String dataBasePath;
    String path;
    ConnectInfoUtil util = ConnectInfoUtil();
    getDatabasesPath().then((value) {
      dataBasePath = value;
      path = join(dataBasePath, 'connInfo.db');
      util.open(path).then((value2) {
        util.getAll().then((onValue) {
          if (onValue != null) {
            setState(() {
              _connList = onValue;
              _connInfoList = List<ConnectInfo>();
              for (var item in _connList) {
                ConnectInfo conn = ConnectInfo.fromMap(item);
                _connInfoList.add(conn);
              }
              _connListFlag = true;
            });
          }
        });
      });
    });
  }

  getListView(){
    if(_connListFlag){
      //print('list不为空');
      return ListView.builder(
        physics: new ClampingScrollPhysics(),
        itemCount: _connInfoList.length,
        itemBuilder: (BuildContext context,int position){
          return getItem(position);
        },
      );
    }else{
      //print('列表是空的');
      //initList();
      return Center(
        child: Text('请刷新'),
      );
    }
  }
  getItem(int position){
    return ListTile(
      title: Text(_connInfoList[position].nick),
      subtitle: Text(_connInfoList[position].host),
      onTap: (){
        _connInfoList[position].printUtil();
      },
    );
  }
}
