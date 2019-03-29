import 'package:flutter/material.dart';

import 'app.dart';
import 'loading.dart';
import 'package:wanandroid_demo/login/login_page.dart';
import 'package:wanandroid_demo/home/home_page.dart';

void main() {
  runApp(MyApp());

//  if (Platform.isAndroid) {
//    SystemUiOverlayStyle style =
//        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
//    SystemChrome.setSystemUIOverlayStyle(style);
//  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "玩android",
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primaryColor: const Color(0xFF5394FF),
          scaffoldBackgroundColor: Color(0xFFEBEBEB),
          accentColor: const Color(0xff5394ff)),
//      routes: <String, WidgetBuilder>{
//        "app": (BuildContext context) => new App()
//      },
      home: new LoginPage(),
    );
  }
}
