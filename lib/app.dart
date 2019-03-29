/**
 *  Created by liuyin on 2019/3/13 14:06
 *  Description:
 */
import 'package:flutter/material.dart';
import 'package:wanandroid_demo/home/home_page.dart';

import 'knowledge/knowledge.dart';
import 'publicc/publicc.dart';
import 'navigation/navigation.dart';
import 'project/project.dart';
import 'drawer/drawerpage.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AppState();
  }
}

class AppState extends State<App> {
  var pages = <Widget>[HomePage(), Knowledge(),Publicc(),Navigation(),Project()];
  int _selectIndex = 0;
  final appBarTitles = ["首页", "体系", "公众号", "导航", "项目"];
  bool _showAppbar = true;
  bool _showDrawer = true;

  @override
  Widget build(BuildContext context) {
    Widget widget = new WillPopScope(
      child: Scaffold(
        drawer: _showDrawer?DrawerPage():null,
        appBar: _showAppbar
            ? AppBar(
                centerTitle: true,
                title: new Text(appBarTitles[_selectIndex]),
              )
            : null,
        body: new IndexedStack(
          children: pages,
          index: _selectIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment), title: Text('体系')),
            BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('公众号')),
            BottomNavigationBarItem(
                icon: Icon(Icons.navigation), title: Text('导航')),
            BottomNavigationBarItem(icon: Icon(Icons.book), title: Text('项目'))
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectIndex,
          onTap: _onItemTapped,
        ),
      ),
      onWillPop: _onWillPop,
    );
    return widget;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
      if (_selectIndex == 0 || _selectIndex == 1 || _selectIndex == 3) {
        _showAppbar = true;
      } else {
        _showAppbar = false;
      }
      if (_selectIndex == 0) {
        _showDrawer = true;
      } else {
        _showDrawer = false;
      }
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
        context: context,
        builder: (context) =>
            new AlertDialog(
              title: new Text("提示"),
              content: new Text("确定退出应用吗?"),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text("再看一会")),
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text("退出"))
              ],
            ) ??
            false);
  }
}
