import 'package:flutter/material.dart';

/**
 *  Created by liuyin on 2019/3/13 20:28
 *  Description:
 */
class Knowledge extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new KnowledgeState();
  }
}

class KnowledgeState extends State<Knowledge> {
  @override
  Widget build(BuildContext context) {
    Widget widget = new Scaffold(
      body: new Center(
        child: new Text("我是体系"),
      ),
    );
    return widget;
  }
}
