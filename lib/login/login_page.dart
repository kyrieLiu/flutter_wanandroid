import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wanandroid_demo/common/application.dart';
import 'package:wanandroid_demo/common/user.dart';
import 'package:wanandroid_demo/event/login_event.dart';
import 'package:wanandroid_demo/http/common_service.dart';
import 'package:wanandroid_demo/model/user_model.dart';
import 'package:wanandroid_demo/util/bubble_indication_painter.dart';

import 'theme.dart' as Theme;

///  Created by liuyin on 2019/3/21 15:45
/// Description:
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  String title = "登录";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;
  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        key: _scaffoldKey,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
          },
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height >= 775.0
                  ? MediaQuery.of(context).size.height
                  : 775.0,
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientStart,
                        Theme.Colors.loginGradientEnd
                      ],
                      begin: const FractionalOffset(0, 0),
                      end: const FractionalOffset(1, 1),
                      stops: [0, 1],
                      tileMode: TileMode.clamp)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: _buildMenuBar(context),
                  ),
                  Expanded(
                      flex: 2,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (i) {
                          if (i == 0) {
                            setState(() {
                              right = Colors.white;
                              left = Colors.black;
                              title = "登录";
                            });
                          } else if (i == 1) {
                            setState(() {
                              right = Colors.black;
                              left = Colors.white;
                              title = "注册";
                            });
                          }
                        },
                        children: <Widget>[
                          ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: _buildSignIn(context),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: _buildSignUp(context),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  width: 300,
                  height: 150,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 25, right: 25),
                        child: TextField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(FontAwesomeIcons.user,
                                  color: Colors.black, size: 18),
                              hintText: "用户名",
                              hintStyle: TextStyle(fontSize: 17)),
                        ),
                      ),
                      Container(
                        width: 250,
                        height: 1,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 25, right: 25),
                        child: TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.lock,
                                size: 22,
                                color: Colors.black,
                              ),
                              hintText: "密码",
                              hintStyle: TextStyle(fontSize: 17),
                              suffixIcon: GestureDetector(
                                onTap: _toggleLogin,
                                child: Icon(
                                  FontAwesomeIcons.eye,
                                  size: 15,
                                  color: Colors.black,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 240),
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Theme.Colors.loginGradientStart,
                          offset: Offset(1, 6),
                          blurRadius: 20),
                      BoxShadow(
                          color: Theme.Colors.loginGradientEnd,
                          offset: Offset(1, 6),
                          blurRadius: 20)
                    ],
                    gradient: new LinearGradient(
                        colors: [
                          Theme.Colors.loginGradientEnd,
                          Theme.Colors.loginGradientStart
                        ],
                        begin: const FractionalOffset(0.2, 0.2),
                        end: const FractionalOffset(1, 1),
                        stops: [0, 1],
                        tileMode: TileMode.clamp)),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: const Color(0xFF5394FF),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    color: const Color(0xFF5394FF),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 60.0),
                      child: Text(
                        "登录",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      print("开始登录");
                      _login();
                    }),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<Null> _login() async {
    print("开始登录");
    String username = loginEmailController.text;
    String password = loginPasswordController.text;
    if ((null != username && username.trim().length > 0) &&
        (null != password && password.trim().length > 0)) {
      CommonService().login((UserModel _userModel, Response response) {
        if (_userModel != null && _userModel.errorCode == 0) {
          User().saveUserInfo(_userModel, response);
          Application.eventBus.fire(new LoginEvent());
          Fluttertoast.showToast(msg: "登录成功");
          Navigator.of(context).pop();
        } else {
          Fluttertoast.showToast(msg: _userModel.errorMsg);
        }
      }, username, password);
    }
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                  width: 300,
                  height: 210,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 25, right: 25),
                        child: TextField(
                          focusNode: myFocusNodeName,
                          controller: signupNameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.user,
                                color: Colors.black,
                              ),
                              hintText: "用户名",
                              hintStyle: TextStyle(fontSize: 16)),
                        ),
                      ),
                      Container(
                        width: 250,
                        height: 1,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 25, right: 25),
                        child: TextField(
                          focusNode: myFocusNodePassword,
                          controller: signupPasswordController,
                          obscureText: _obscureTextSignup,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.black,
                              ),
                              hintText: "密码",
                              hintStyle: TextStyle(fontSize: 16),
                              suffixIcon: GestureDetector(
                                onTap: _toggleSignup,
                                child: Icon(
                                  FontAwesomeIcons.eye,
                                  size: 15,
                                  color: Colors.black,
                                ),
                              )),
                        ),
                      ),
                      Container(
                        width: 250,
                        height: 1,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, right: 25, left: 25),
                        child: TextField(
                          controller: signupConfirmPasswordController,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          obscureText: _obscureTextSignupConfirm,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.black,
                              ),
                              hintText: "确认密码",
                              hintStyle: TextStyle(fontSize: 16),
                              suffixIcon: GestureDetector(
                                onTap: _toggleConfirmPassword,
                                child: Icon(
                                  FontAwesomeIcons.eye,
                                  size: 15,
                                  color: Colors.black,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 340.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: const Color(0xFF5394FF),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    color: const Color(0xFF5394FF),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 60.0),
                      child: Text(
                        "注册",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    onPressed: () {
                      _regist();
                    }),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<Null> _regist() async {
    String userName = signupNameController.text;
    String password = signupPasswordController.text;
    String rePassword = signupConfirmPasswordController.text;
    if ((null != userName && userName.trim().length > 0) &&
        (null != password && password.trim().length > 0) &&
        rePassword != null &&
        rePassword.length > 0) {
      if (password != rePassword) {
        Fluttertoast.showToast(msg: "两次密码输入不一致!");
      } else {
        CommonService().register((UserModel _userModel) {
          if (_userModel.errorCode == 0) {
            Fluttertoast.showToast(msg: "注册成功!");
          } else {
            Fluttertoast.showToast(msg: _userModel.errorMsg);
          }
        }, userName, password);
      }
    } else {
      Fluttertoast.showToast(
        msg: "用户名或者密码不能为空",
      );
    }
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0x552b2b2b),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: _onSignInButtonPress,
                  child: Text(
                    "登录",
                    style: TextStyle(color: left, fontSize: 16),
                  )),
            ),
            Expanded(
              child: FlatButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: _onSignUpButtonPress,
                  child: Text(
                    "注册",
                    style: TextStyle(color: right, fontSize: 16),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  //切换到注册
  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleConfirmPassword(){
    setState(() {
      _obscureTextSignupConfirm=!_obscureTextSignupConfirm;
    });
  }
}
