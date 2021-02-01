import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_appclient/config/baseConfig.dart';
import 'package:flutter_appclient/mobileUI/Button/simpleButton.dart';
import 'package:flutter_appclient/mobileUI/privacy.dart';
import 'package:flutter_appclient/store/provider.dart';
import 'package:flutter_appclient/utils/sputils.dart';
import 'package:provider/provider.dart';

/// @description: 登陆
/// @fileName: login.dart
/// @author: 谭人杰
/// @date: 2020-09-16 17:11:24
/// @后台人员:
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 响应空白处的焦点的Node
  bool _isShowPassWord = false;
  FocusNode blankNode = FocusNode();
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (!SPUtils.isAgreePrivacy()) {
      PrivacyUtils.showPrivacyDialog(context, onAgressCallback: () {
        Navigator.of(context).pop();
        SPUtils.saveIsAgreePrivacy(true);
        EasyLoading.showSuccess("已同意隐私协议!");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Container(
            color: BaseConfig.theme.withOpacity(0.1),
            height: double.infinity,
            child: GestureDetector(
              onTap: () {
                // 点击空白页面关闭键盘
                closeKeyboard(context);
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                child: buildForm(context),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return Future.value(false);
        });
  }

  //构建表单
  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: false,
      child: Column(
        children: <Widget>[
          TextFormField(
              autofocus: false,
              controller: _unameController,
              decoration: InputDecoration(
                hintText: "请输入用户名",
                hintStyle: TextStyle(fontSize: ScreenUtil().setSp(12)),
                icon: Icon(
                  Icons.person,
                ),
              ),
              //校验用户名
              validator: (v) {
                return v.trim().length > 0 ? null : "用户名不可为空";
              }),
          TextFormField(
            controller: _pwdController,
            decoration: InputDecoration(
                // labelText: "密码",
                hintText: "请输入密码",
                hintStyle: TextStyle(fontSize: 12),
                icon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    icon: Icon(
                      _isShowPassWord ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: showPassWord)),
            obscureText: !_isShowPassWord,
            //校验密码
            validator: (v) {
              return v.trim().length > 0 ? null : "密码不可为空";
            },
          ),
          // 登录按钮
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Builder(
                    builder: (context) {
                      return SimpleButton(
                        text: "登陆",
                        callback: () {
                          //由于本widget也是Form的子代widget，所以可以通过下面方式获取FormState
                          if (Form.of(context).validate()) {
                            onSubmit(context);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///点击控制密码是否显示
  void showPassWord() {
    setState(() {
      _isShowPassWord = !_isShowPassWord;
    });
  }

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(blankNode);
  }

  //验证通过提交数据
  void onSubmit(BuildContext context) {
    closeKeyboard(context);

    UserInfoStore userInfo = Provider.of<UserInfoStore>(context, listen: false);
    userInfo.userInfo = json.encode({
      "token": "111",
      "user": {},
    });
    Navigator.of(context).pushReplacementNamed('/home');
  }
}
