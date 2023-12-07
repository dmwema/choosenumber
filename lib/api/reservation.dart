import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../main.dart';
import '../utils/utilities.dart';

class ReserVationApi {
  static Future<Response> post(Map<String, dynamic> reservation) async {
    print(AppUtils.http.RESERVATION);
    print(reservation);
    var token = GetStorage().read("token");
    AppUtils.http.headers['Authorization'] = "Bearer $token";
    return await dio.post(
      AppUtils.http.RESERVATION,
      data: reservation,
      options: Options(headers: AppUtils.http.headers, followRedirects: true),
    );
    // return await http.get(Configs.http.GET_PING, headers: Configs.http.headers);
  }

  static Future<Response> FindNumbers(
      String criteria, String val, String? category) async {
    var token = GetStorage().read("token");
    AppUtils.http.headers['Authorization'] = "Bearer $token";
    print(AppUtils.http.chooseNumber(criteria, val, category));
    return await dio.get(
      AppUtils.http.chooseNumber(criteria, val, category),
      options: Options(headers: AppUtils.http.headers),
      onReceiveProgress: (max, progress) {
        printDebug("max: $max ; progress: $progress");
      },
    );
  }

  static Future<Response> getList(String id) async {
    var token = GetStorage().read("token");
    AppUtils.http.headers['Authorization'] = "Bearer $token";
    return await dio.get(
      AppUtils.http.RESERVATION_BY_USER(id),
      options: Options(headers: AppUtils.http.headers),
      onReceiveProgress: (max, progress) {
        printDebug("max: $max ; progress: $progress");
      },
    );
  }

  /*static Future<Response> getListByCreator() async {
    var token = GetStorage().read("token");
    AppUtils.http.headers['Authorization'] = "Bearer $token";
    return await dio.get(
      AppUtils.http.RECONCIL_BY_CREATOR,
      options: Options(headers: AppUtils.http.headers),
      onReceiveProgress: (max, progress) {
        printDebug("max: $max ; progress: $progress");
      },
    );
  }*/

  /*static Future<Response> getListByUser(int id) async {
    var token = GetStorage().read("token");
    AppUtils.http.headers['Authorization'] = "Bearer $token";
    return await dio.get(
      AppUtils.http.RECONCIL_BY_USER(id),
      options: Options(headers: AppUtils.http.headers),
      onReceiveProgress: (max, progress) {
        printDebug("max: $max ; progress: $progress");
      },
    );
  }*/
}
