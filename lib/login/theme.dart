import 'dart:ui';
import 'package:flutter/cupertino.dart';
///  Created by liuyin on 2019/3/22 11:33
/// Description:
class Colors {
  const Colors();

  static const Color loginGradientStart = const Color(0xffffffff);
  static const Color loginGradientEnd = const Color(0xffffffff);

  static const primaryGradient = const LinearGradient(
      colors: const [loginGradientStart, loginGradientEnd],
      stops: const[0, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter
  );

}
