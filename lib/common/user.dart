import 'package:wanandroid_demo/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

///  Created by liuyin on 2019/3/19 9:25
/// Description:
class User {
  static final User singleton = User._internal();

  factory User() {
    return singleton;
  }

  User._internal();

  List<String> cookie;
  String userName;

  void saveUserInfo(UserModel _userModel,Response response){
    cookie=response.headers["set-cookie"];
    userName=_userModel.data.username;
  }

  saveInfo() async{
      SharedPreferences sp=await SharedPreferences.getInstance();
      sp.setStringList("cookies", cookie);
      sp.setString("username", userName);
  }

}
