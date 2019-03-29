import 'package:flutter/material.dart';

/**
 *  Created by liuyin on 2019/3/13 20:40
 *  Description:
 */
class Project extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new ProjectState();
  }
}
class ProjectState extends State<Project>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text('我是项目'),
      ),
    );
  }

}