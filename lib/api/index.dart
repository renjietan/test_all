import 'package:flutter_appclient/utils/core/http.dart';

class API {
  static Future submit(Map<String, dynamic> params) {
    print("参数:$params");
    return XHttp.post("/submit", params);
  }

  static Future getlist(Map<String, dynamic> params) {
    print("参数:$params");
    return XHttp.get("/list", params);
  }
}
