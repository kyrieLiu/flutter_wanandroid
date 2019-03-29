import 'package:flutter/material.dart';

/**
 *  Created by liuyin on 2019/3/13 20:33
 *  Description:
 */
class Publicc extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new PubliccState();
  }
  
}
class PubliccState extends State<Publicc>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Text('我是公众号'),
      ),
    );
  }
  
}