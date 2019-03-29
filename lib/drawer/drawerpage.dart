import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Created by liuyin on 2019/3/13 20:47
/// Description:

class DrawerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DrawerPageState();
  }
}

class DrawerPageState extends State<DrawerPage> {
  bool isLogin = false;
  String userName = '未登录';

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: InkWell(
              child: Text(
                userName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              onTap: () {
                if (!isLogin) {
//                  Navigator.of(context).push(new MaterialPageRoute(
//                      builder: (context) => new DrawerPage()));
                }
              },
            ),
            currentAccountPicture: InkWell(
              child: CircleAvatar(
                backgroundImage: AssetImage("images/head.jpg"),
              ),
            ),
          ),
          ListTile(
            title: Text(
              '我的收藏',
              textAlign: TextAlign.left,
            ),
            leading: Icon(
              Icons.collections,
              size: 22,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              '常用网站',
              textAlign: TextAlign.left,
            ),
            leading: Icon(
              Icons.web,
              size: 22,
            ),
          ),
          ListTile(
            title: Text(
              '分享',
              textAlign: TextAlign.left,
            ),
            leading: Icon(
              Icons.share,
              size: 22,
            ),
            onTap: () {
              Fluttertoast.showToast(msg: '分享');
            },
          )
        ],
      ),
    );
  }
}
