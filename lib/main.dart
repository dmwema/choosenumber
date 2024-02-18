import 'package:choosenumber/controller/imagePickerController.dart';
import 'package:choosenumber/controller/reservation_controller.dart';
import 'package:choosenumber/res/strings.dart';
import 'package:choosenumber/screens/homeScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:choosenumber/screens/loginScreen.dart';
import 'package:get_storage/get_storage.dart';

import 'controller/auth_controller.dart';

var dio = Dio();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  /*dio.interceptors.add(
    InterceptorsWrapper(
      /*onRequest: (options, handler) {
      // Add the access token to the request header
      options.headers['Authorization'] = 'Bearer your_access_token';
      return handler.next(options);
    },*/
      onError: (DioError e, handler) async {
        if (e.response?.statusCode == 401) {
          // If a 401 response is received, refresh the access token
          String newAccessToken = await refreshToken();

          // Update the request header with the new access token
          e.requestOptions.headers['Authorization'] =
              'Bearer ${GetStorage().read("token")}';

          // Repeat the request with the updated header
          return handler.resolve(await dio.fetch(e.requestOptions));
        }
        return handler.next(e);
      },
    ),
  );
  */
  runApp(MyApp());
}

refreshToken() {
  AuthController pagesController = Get.put(AuthController());

  if (pagesController.user.value != null) {
    print("refreshing... from main");
    pagesController.refreshToken();
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  AuthController pagesController = Get.put(AuthController());
  ReservationController resController = Get.put(ReservationController());
  //ZoneController zoneController = Get.put(ZoneController());
  //ImagePickerController imageController = Get.put(ImagePickerController());
  //var aboneController = Get.put(AboneController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
