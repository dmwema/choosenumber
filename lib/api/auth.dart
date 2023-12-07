import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../main.dart';
import '../utils/utilities.dart';

class Auth {
  /// User methods start

  static Future<Response> get(String id, String token) async {
    AppUtils.http.headers['Authorization'] = "Bearer $token";
    return await dio.get(
      AppUtils.http.AUTH(id),
      options: Options(
        headers: AppUtils.http.headers,
      ),
      onReceiveProgress: (max, progress) {
        printDebug("max: $max ; profress: $progress");
      },
    );
  }

  static Future<Response> getList() async {
    var token = GetStorage().read("token");
    AppUtils.http.headers['Authorization'] = "Bearer $token";
    return await dio.get(
      AppUtils.http.USER_BY_CREATOR,
      options: Options(headers: AppUtils.http.headers),
      onReceiveProgress: (max, progress) {
        printDebug("max: $max ; profress: $progress");
      },
    );
  }

  static Future<Response> modify(
      String id, String token, Map<String, dynamic> user) async {
    AppUtils.http.headers['Authorization'] = "Bearer $token";
    return await dio.put(
      AppUtils.http.AUTH(id),
      data: user,
      options: Options(headers: AppUtils.http.headers),
    );
  }

  static Future<Response> login(Map<String, dynamic> user) async {
    print(AppUtils.http.POST_LOGIN);
    return await dio.post(
      AppUtils.http.POST_LOGIN,
      //data: {'grant_type':'password','username':user['username'],'password':user['password'],'client_id':'AficellRetailer_App'},
      data: {'username': user['username'], 'password': user['password']},
      options: Options(contentType: Headers.jsonContentType),
    );
    // return await http.get(Configs.http.GET_PING, headers: Configs.http.headers);
  }

  static Future<Response> refreshLogin() async {
    var token = GetStorage().read("token");
    var refreshToken = GetStorage().read("refresh_token");
    print(AppUtils.http.POST_REFRESH_LOGIN);
    Map<String, dynamic> data = {
      "access_token": token,
      "refresh_token": refreshToken
    };

    return await dio.post(
      AppUtils.http.POST_REFRESH_LOGIN,
      data: data,
      options: Options(headers: AppUtils.http.headers, followRedirects: true),
    );
    // return await http.get(Configs.http.GET_PING, headers: Configs.http.headers);
  }

  static Future<Response> logoff() async {
    var token = GetStorage().read("token");
    AppUtils.http.headers['Authorization'] = "Bearer $token";
    return await dio.post(
      AppUtils.http.POST_LOGOUT,
      options: Options(headers: AppUtils.http.headers),
    );
    // return await http.get(Configs.http.GET_PING, headers: Configs.http.headers);
  }

  static Future<Response> register(Map<String, dynamic> user) async {
    return await dio.post(
      AppUtils.http.POST_REGISTER,
      data: user,
      options: Options(headers: AppUtils.http.headers),
    );
    print(user);
    /*return await dio.get(
      AppUtils.http.POST_REGISTER,
      queryParameters: user,
      options: Options(headers: AppUtils.http.headers),
    );*/
    // return await http.get(Configs.http.GET_PING, headers: Configs.http.headers);
  }

  static Future<Response> forgot(Map<String, dynamic> user) async {
    printDebug(AppUtils.http.headers.toString());
    printDebug(AppUtils.http.POST_LOGIN);
    return await dio.post(
      AppUtils.http.POST_FORGOT_PASS,
      data: user,
      options: Options(headers: AppUtils.http.headers),
    );
    // return await http.get(Configs.http.GET_PING, headers: Configs.http.headers);
  }

  static Future<Response> forgotValidate(Map<String, dynamic> user) async {
    printDebug(AppUtils.http.headers.toString());
    printDebug(AppUtils.http.POST_LOGIN);
    return await dio.post(
      AppUtils.http.POST_FORGOT_VALIDATE,
      data: user,
      options: Options(headers: AppUtils.http.headers),
    );
    // return await http.get(Configs.http.GET_PING, headers: Configs.http.headers);
  }

  static Future<Response> passwordChange(Map<String, String> user) async {
    var token = GetStorage().read("token");
    print(token);
    print(user);
    print(AppUtils.http.POST_FORGOT_RESET);
    AppUtils.http.headers['Authorization'] = "Bearer $token";
    return await dio.post(
      AppUtils.http.POST_FORGOT_RESET,
      data: user,
      options: Options(headers: AppUtils.http.headers),
    );
  }

  /// User methods end
}
