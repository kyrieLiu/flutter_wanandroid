import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid_demo/common/application.dart';
import 'package:wanandroid_demo/common/user.dart';
import 'package:wanandroid_demo/event/login_event.dart';
import 'package:wanandroid_demo/login/login_page.dart';

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
    registerLoginEvent();
    if(null!=User.singleton.userName){
      isLogin = true;
      userName =User.singleton.userName;
    }
  }

  void registerLoginEvent() {
    Application.eventBus.on<LoginEvent>().listen((event) {
      changeUI();
    });
  }

  changeUI() async {
    setState(() {
      isLogin = true;
      userName = User.singleton.userName;
    });
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
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (context) {
                    return new LoginPage();
                  }));
                }
              },
            ),
            currentAccountPicture: InkWell(
              child: CircleAvatar(
                backgroundImage: AssetImage("images/head.jpg"),
              ),
              onTap: () {
                if (!isLogin) {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (context) {
                    return new LoginPage();
                  }));
                }
              },
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
          ),
          logoutWidget()
        ],
      ),
    );
  }

  Widget logoutWidget() {
    if (User.singleton.userName != null) {
      return ListTile(
        title: Text("退出登录", textAlign: TextAlign.left),
        leading: Icon(
          Icons.power_settings_new,
          size: 22,
        ),
        onTap: () {
          User.singleton.clearInfo();
          setState(() {
            isLogin = false;
            userName = "未登录";
          });
        },
      );
    }
    else{
      return SizedBox(
        height: 0,
      );
    }
  }
}
