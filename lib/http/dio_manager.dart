import 'package:dio/dio.dart';

///  Created by liuyin on 2019/3/14 20:31
/// Description:
class DioManager {
  Dio _dio;

  DioManager._internal() {
    _dio = new Dio();
  }

  static DioManager singleton = DioManager._internal();

  factory DioManager() => singleton;

  get dio {
    return _dio;
  }
}
