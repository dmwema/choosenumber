import 'dart:convert';
import 'dart:io';

import 'package:choosenumber/model/newUser.dart';
import 'package:choosenumber/res/colors.dart';
import 'package:choosenumber/res/strings.dart';
import 'package:choosenumber/screens/homeScreen.dart';
import 'package:choosenumber/screens/loginScreen.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api/auth.dart';

import '../model/user.dart';
import '../utils/utilities.dart';
import '../widgets/sundry_components.dart';

class AuthController extends GetxController {
  late final sessionToken;
  var user = Rxn<User>();
  var isLoggedIn = false.obs;
  var login_process = false.obs;
  var logoff_process = false.obs;
  var register_process = false.obs;
  var unregister_process = false.obs;

  var modify_process = false.obs;

  var retrieve_pass_process = false.obs;

  var restEmail = "".obs;
  var codeSent = false.obs;
  var codeValidated = false.obs;
  var temp_user = Rxn<User>();

  var refreshing_process = false.obs;
  var myUsers = <NewUser>[].obs;

  var process_users = false.obs;

  changePassword(Map<String, String> xuser) {
    retrieve_pass_process.value = true;
    Auth.passwordChange(xuser).then((value) {
      if (value.statusCode == 200) {
        retrieve_pass_process.value = false;
        Get.closeAllSnackbars();
        popSnackSuccess(
          message: value.data['message'],
        );
      } else {
        retrieve_pass_process.value = false;
        popSnackError(message: value.data['message']);
      }
    }).onError((dio.DioError error, stacktrace) {
      retrieve_pass_process.value = false;
      print(error.response!.statusCode);
      popSnackError(message: error.response!.data['message']);
    });
  }

  logoff() {
    //logoff_process.value = true;
    GetStorage().remove("user");
    GetStorage().remove("token");
    user.value = null;
    Get.offAll(() => LoginScreen(),
        transition: AppUtils.pageTransition,
        duration: Duration(milliseconds: AppUtils.timeTransition));
  }

  delayIntroScreen() async {
    await Future.delayed(Duration(seconds: AppUtils.timeInterval));
    autoLogin();
  }

  login1(Map<String, dynamic> creds) {
    var _user = User(
        id: "1",
        name: "admin",
        phone: "900100118",
        access_token: "oiuetryfdjhb dnm",
        roles: ["User"],
        refresh_token: "oiuyutyeioiud",
        status: "1");
    var token = "oiuetryfdjhb dnm";

    GetStorage().write("user", _user.toMap());
    GetStorage().write("token", token);
    user.value = _user;
    Get.off(() => const HomeScreen(),
        transition: AppUtils.pageTransition,
        duration: Duration(milliseconds: AppUtils.timeTransition));
  }

  login(Map<String, dynamic> creds) {
    login_process.value = true;
    Auth.login(creds).then((value) {
      if (value.statusCode == 401) {
        popSnackError(message: "Invalid credentials");
        return;
      }
      if (value.data['access_token'] != null) {
        try {
          final encodedPayload = value.data['access_token'].split('.')[1];
          final payloadData =
              utf8.fuse(base64).decode(base64.normalize(encodedPayload));
          //print( payloadData);

          User _user = User.fromJson(null, jsonDecode(payloadData));
          print(_user);
          if (_user.id != null) {
            Get.closeAllSnackbars();
            print("save token");
            /* popSnackSuccess(
              message: value.data['message'],
            );*/
            _user.access_token = value.data['access_token'];
            _user.refresh_token = value.data['refresh_token'];
            //print(_user.refresh_token);
            user.value = _user;
            isLoggedIn.value = true;
            GetStorage().write("user", _user.toMap());
            GetStorage().write("token", value.data['access_token']);
            GetStorage().write("refresh_token", value.data['refresh_token']);
            print("zoneId ${_user.zoneId}");
            GetStorage().write("zoneId", _user.zoneId);
            login_process.value = false;

            Get.off(() => const HomeScreen(),
                transition: AppUtils.pageTransition,
                duration: Duration(milliseconds: AppUtils.timeTransition));
          } else {
            popSnackError(message: "Invalid credentials");
            //popSnackError(message: value.data['message']);
          }
        } catch (_) {
          print("error ${value.statusCode}");
          popSnackError(message: "Invalid credentials");
          //popSnackError(message: value.data['message']);
        }
      } else {
        popSnackError(message: "Invalid credentials");
        //popSnackError(message: value.data['message']);
      }
    }).onError((dio.DioException error, stackTrace) {
      if (error.response != null) {
        popSnackError(
            title: "Error", message: "${error.response!.data['message']}");
      } else {
        print(error);
        popSnackError(
            title: "Error", message: "Error occurred please try again");
      }
    }).whenComplete(() {
      login_process.value = false;
    });
  }

  autoLogin() async {
    //print("this");
    try {
      var uu = GetStorage().read("user");
      var token = GetStorage().read("token");
      print(uu);
      User _user = User.fromJson2(null, uu);
      print(_user);
      user.value = _user;
      print(GetStorage().read("zoneId"));

      isLoggedIn.value = true;
      refreshToken();
      //getMyUsers();
      //refreshToken();
      Get.offAll(() => const HomeScreen(),
          transition: AppUtils.pageTransition,
          duration: Duration(milliseconds: AppUtils.timeTransition));
    } catch (_) {
      print("OUTER CATCH ERROR : ${_.toString()}");
      isLoggedIn.value = false;
      Get.offAll(() => LoginScreen(),
          transition: AppUtils.pageTransition,
          duration: Duration(milliseconds: AppUtils.timeTransition));
    }
  }

  Future<String> refreshToken() async {
    refreshing_process.value = true;
    print("refresh: ${user.value!.refresh_token!}");
    Auth.refreshLogin().then((value) {
      if (value.data['access_token'] != null) {
        try {
          final encodedPayload = value.data['access_token'].split('.')[1];
          final payloadData =
              utf8.fuse(base64).decode(base64.normalize(encodedPayload));
          print(payloadData);

          User _user = User.fromJson(null, jsonDecode(payloadData));
          print(_user);
          if (_user.id != null) {
            Get.closeAllSnackbars();
            print("save token");
            /* popSnackSuccess(
              message: value.data['message'],
            );*/
            _user.access_token = value.data['access_token'];
            _user.refresh_token = value.data['refresh_token'];
            //print(_user.refresh_token);
            user.value = _user;
            isLoggedIn.value = true;
            GetStorage().write("user", _user.toMap());
            GetStorage().write("token", value.data['access_token']);
            GetStorage().write("refresh_token", value.data['refresh_token']);
            refreshing_process.value = false;

            /*Get.off(() => const HomeScreen(),
                transition: AppUtils.pageTransition,
                duration: Duration(milliseconds: AppUtils.timeTransition));*/
          } else {
            refreshing_process.value = false;
            popSnackError(message: "Invalid credentials");
            //popSnackError(message: value.data['message']);
          }
          return _user.access_token;
        } catch (_) {
          print("error ${value.statusCode}");
          popSnackError(message: "Invalid credentials");
          //popSnackError(message: value.data['message']);
          return "";
          refreshing_process.value = false;
        }
      } else {
        popSnackError(message: "Invalid credentials");
        logoff();
        refreshing_process.value = false;
      }
    }).onError((dio.DioError error, stackTrace) {
      print("error refresh: ${error.response!.data}");
      if (error.response != null && error.response!.statusCode == 401) {
        //Get.closeAllSnackbars();
        popSnackError(message: "Session has expired, please sign in again");
        //logoff();
      }
      if (error.response != null && error.response!.statusCode == 400) {
        print(error.response!.data);
        //Get.closeAllSnackbars();
        popSnackError(message: "Session has expired, please sign in again");
        //logoff();
      }
      refreshing_process.value = false;
      return "";
    });
    return "";
  }

  /* getMyUsers() async {
    usersInfo.value = CloudStorageInfo(
        title:
            user.value!.roles!.contains(MANAGER) ? "Supervisors" : "Managers",
        numOfFiles: 0,
        totalStorage: "users",
        color: primaryWhite,
        svgSrc: "assets/icons/menu_profile.svg",
        onPress: () => user.value!.roles!.contains(MANAGER) ||
                user.value!.roles!.contains("Admin")
            ? Get.to(() => const UsersScreen())
            : null);
    monthUsersInfo.value = CloudStorageInfo(
        title:
            user.value!.roles!.contains(MANAGER) ? "Supervisors" : "Managers",
        numOfFiles: 0,
        totalStorage: "users",
        color: primaryWhite,
        svgSrc: "assets/icons/menu_profile.svg",
        onPress: () => user.value!.roles!.contains(MANAGER) ||
                user.value!.roles!.contains("Admin")
            ? Get.to(() => const UsersScreen(
                  type: 1,
                ))
            : null);
    process_users.value = true;
    Auth.getList().then((value) async {
      if (value.statusCode == 200) {
        List<NewUser> lz = await NewUser.newUsersfromJson(value.data);
        myUsers.value = lz;
        monthMyUsers.value = lz
            .where((element) =>
                DateTime.parse(element.createdAt!).month ==
                DateTime.now().month)
            .toList();
        usersInfo.value = CloudStorageInfo(
            title: user.value!.roles!.contains(MANAGER)
                ? "Supervisors"
                : "Managers",
            numOfFiles: lz.length,
            totalStorage: "users",
            color: primaryWhite,
            svgSrc: "assets/icons/menu_profile.svg",
            onPress: () => user.value!.roles!.contains("User")
                ? null
                : Get.to(() => const UsersScreen()));
        monthUsersInfo.value = CloudStorageInfo(
            title: user.value!.roles!.contains(MANAGER)
                ? "Supervisors"
                : "Managers",
            numOfFiles: monthMyUsers.value.length,
            totalStorage: "users",
            color: primaryWhite,
            svgSrc: "assets/icons/menu_profile.svg",
            onPress: () => user.value!.roles!.contains("User")
                ? null
                : Get.to(() => const UsersScreen(
                      type: 1,
                    )));
      }
      process_users.value = false;
    }).onError((DioError error, stackTrace) {
      process_users.value = false;
      print("list users ${error.response}");
      popSnackError(message: "Cannot retrieve your users.");
    });
  }*/

  @override
  onReady() async {}

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //sessionToken = const Uuid().v4();
    delayIntroScreen();
  }
  // upload to firebase storage
}
