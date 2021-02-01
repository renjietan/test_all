import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_appclient/config/baseConfig.dart';
import 'package:flutter_appclient/utils/core/path.dart';

import '../sputils.dart';

class XHttp {
  XHttp._internal();
  static final List<String> whiteList = [
    "/app/user/login",
    "/user/register",
    "/submit"
  ];

  ///网络请求配置
  static final Dio dio = Dio(BaseOptions(
    baseUrl: BaseConfig.baseUrl,
    connectTimeout: 60000,
    receiveTimeout: 30000,
  ));

  ///初始化dio
  static init() {
    ///初始化cookie
    PathUtils.getDocumentsDirPath().then((value) {
      var cookieJar = PersistCookieJar(dir: value + "/.cookies/");
      dio.interceptors.add(CookieManager(cookieJar));
    });

    //添加拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      final cookie = SPUtils.getUserInfo();
      EasyLoading.show();
      if (whiteList.where((element) => element == options.path).length == 0) {
        if (cookie == null) {
          EasyLoading.showError("安全令牌已失效，请重新登陆");
          BaseConfig.navigatorKey.currentState.pushReplacementNamed('/login');
          return options;
        }
        options.headers["token"] = jsonDecode(cookie)["token"];
      }
      return options;
    }, onResponse: (Response response) {
      EasyLoading.dismiss();
      if (response.data["code"] == 20000) {
        return dio.resolve(response.data);
      } else {
        return dio.reject(DioError(error: response.data["msg"]));
      }
    }, onError: (DioError e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message);
      return e;
    }));
  }

  ///error统一处理
  static void handleError(DioError e) {
    switch (e.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        print("连接超时");
        break;
      case DioErrorType.SEND_TIMEOUT:
        print("请求超时");
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        print("响应超时");
        break;
      case DioErrorType.RESPONSE:
        print("出现异常");
        break;
      case DioErrorType.CANCEL:
        print("请求取消");
        break;
      default:
        print("未知错误");
        break;
    }
  }

  ///get请求
  static Future get(String url, [Map<String, dynamic> params]) async {
    Response response;
    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    return response.data;
  }

  ///post 表单请求
  static Future post(String url, [Map<String, dynamic> params]) async {
    Response response = await dio.post(url, queryParameters: params);
    return response.data;
  }

  ///post body请求
  static Future postJson(String url, [Map<String, dynamic> data]) async {
    Response response = await dio.post(url, data: data);
    return response.data;
  }

  ///下载文件
  static Future downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        print("$count $total");
      });
    } on DioError catch (e) {
      handleError(e);
    }
    return response.data;
  }
}
