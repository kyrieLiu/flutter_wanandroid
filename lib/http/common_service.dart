import 'package:dio/dio.dart';
import 'package:wanandroid_demo/common/user.dart';
import 'package:wanandroid_demo/model/article_model.dart';
import 'package:wanandroid_demo/model/banner_model.dart';
import 'package:wanandroid_demo/model/user_model.dart';

import 'api.dart';
import 'dio_manager.dart';

///  Created by liuyin on 2019/3/14 20:26
/// Description:首页
class CommonService {
  void getArticleList(Function callback, int _page) async {
    DioManager.singleton.dio
        .get(Api.HOME_ARTICLE_LIST + "$_page/json", options: _getOptions())
        .then((response) {
      print(response.data);
      callback(ArticleModel(response.data));
    });
  }

  void getBanner(Function callback) async {
    DioManager.singleton.dio
        .get(Api.HOME_BANNER, options: _getOptions())
        .then((response) {
      callback(BannerModel(response.data));
    });
  }

  void login(Function callback, String _username, String _password) async {
    FormData formData =
        new FormData.from({"username": _username, "password": _password});
    DioManager.singleton.dio
        .post(Api.USER_LOGIN, data: formData, options: _getOptions())
        .then((response) {
      callback(UserModel(response.data), response);
    });
  }

  void register(Function callback, String _username, String _password) async {
    FormData formData = new FormData.from({
      "username": _username,
      "password": _password,
      "repassword": _password
    });
    DioManager.singleton.dio
        .post(Api.USER_REGISTER, data: formData, options: null)
        .then((response) {
          print(response.data);
      callback(UserModel(response.data));
    });
  }

  Options _getOptions() {
    Map<String, String> map = new Map();
    List<String> cookies = User().cookie;
    map["Cookie"] = cookies.toString();
    return Options(headers: map);
  }
}
