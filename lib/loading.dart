import 'package:flutter/material.dart';

//加载页面
class LoadingPage extends StatefulWidget {
  @override
  _LoadingState createState() => new _LoadingState();
}

class _LoadingState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed("app");
    });

  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Stack(
        children: <Widget>[
          new Image.asset(
            "images/loading.jpg",
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
