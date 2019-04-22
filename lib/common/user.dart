import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid_demo/model/user_model.dart';

///  Created by liuyin on 2019/4/16 16:43
/// Description:

class User {
  static final User singleton = User._internal();

  factory User() {
    return singleton;
  }

  User._internal();

  List<String> cookie;
  String userName;

  void saveUserInfo(UserModel _userModel, Response response) {
    List<String> cookies = response.headers["set-cookie"];
    cookie = cookies;
    userName = _userModel.data.username;
    saveInfo();
  }

  saveInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList("cookies", cookie);
    sp.setString("username", userName);
  }

  Future<Null> getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> cookies = sp.getStringList("cookies");
    if (cookies != null) {
      cookie = cookies;
    }
    String username = sp.getString("username");
    if (username != null) {
      this.userName = username;
    }
  }

  void clearUserInfor() {
    cookie = null;
    userName = null;
    clearInfo();
  }

  clearInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList("cookies", null);
    sp.setString("username", null);
  }
}
