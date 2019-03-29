import 'package:flutter/material.dart';

/**
 *  Created by liuyin on 2019/3/13 20:38
 *  Description:
 */
class Navigation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new NavigationState();
  }
}
class NavigationState extends State<Navigation>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text('我是导航'),
      ),
    );
  }
}