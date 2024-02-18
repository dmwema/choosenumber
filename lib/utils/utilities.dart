import 'dart:developer';

import 'package:get/get.dart';

import '../res/strings.dart';

printDebug(dynamic message) {
  //if (DEBUG) log(message.toString());
  log(message.toString());
}

class AppUtils {
  static _Http http = _Http();
  static _Validator validator = _Validator();

  static Transition pageTransition = Transition.leftToRight;
  static Transition pageTransitionRTL = Transition.rightToLeft;
  static Transition pageTransitionUTD = Transition.upToDown;
  static Transition pageTransitionDTU = Transition.downToUp;
  static Transition pageTransitionZoom = Transition.zoom;

  static double markerSize = 60.0;
  //static int timeInterval = 5;
  static int timeInterval = 2;
  static int timeTransition = 100; //milliseconds
  static int timeRefresh = 1000; //milliseconds
  static int waitingThreshold = 30; //seconds
  static const defaultPadding = 16.0;
}

class _Validator {
  /*
  * TO BE USED AS VALIDATOR METHOD OF TextFormField
  * Check if the email entered has a valid format (eg. info@xyz.com)
   */
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return "email is required";

    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) return "format email invalide";

    return null;
  }

  /*
  * TO BE USED AS VALIDATOR METHOD OF TextFormField
  * Check if the password entered is at least 8 characters long, contains an upper case, a digit and a symbol
   */
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) return "password is required";

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(password)) {
      return '''
    mot de passe doit avoir au moins 8 caractères,
    contenir un majuscule, un chiffre et un symbole
    ''';
    }

    return null;
  }
}

class _Http {
  Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  /// User
  String AUTH(String id) => ACCOUNT_URL + "users/$id";

  String POST_LOGIN = ACCOUNT_URL + 'login';
  String POST_REFRESH_LOGIN = ACCOUNT_URL + 'refresh-token';
  String POST_LOGOUT = ACCOUNT_URL + 'logout';
  String POST_REGISTER = ACCOUNT_URL + 'register/user';
  String USER_BY_CREATOR = ACCOUNT_URL + 'user-creator';
  //String POST_REGISTER_USER = ACCOUNTS_URL + 'register/user';
  String POST_FORGOT_PASS = ACCOUNT_URL + 'resets/forgotpassword';
  String POST_FORGOT_VALIDATE = ACCOUNT_URL + 'resets/verify';
  String POST_FORGOT_RESET = ACCOUNT_URL + 'password/change';
  String RESERVATION = RESERVATION_URL;
  String RESERVATION_BY_USER(String id) => RESERVATION_URL + "by-user/$id";
  String CREATION_LIST = CREATION_URL + "list";

  String chooseNumber(String criteria, String val, String? category) {
    if (category == null) {
      return "${CHOOSE_NUMBER_URL}find?type=$criteria&value=$val";
    }
    return "${CHOOSE_NUMBER_URL}find?type=$criteria&value=$val&category=$category";
  }
}

extension _MyDateTime on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  bool isSameYear(DateTime other) {
    return year == other.year;
  }
}

String _getDate(int days) {
  return DateTime.now().subtract(Duration(days: days)).toString().split(" ")[0];
}

bool isYesterday(String date) {
  return _MyDateTime(DateTime.now().subtract(const Duration(days: 1)))
      .isSameDate(DateTime.parse(date));
}

bool isSameMonth(String date) {
  return _MyDateTime(DateTime.now()).isSameMonth(DateTime.parse(date));
}

String today() {
  return _getDate(0);
}

String aDayAgo() {
  return _getDate(1);
}

bool isNotOlderThanADay(String date) {
  return DateTime.parse(date).isAfter(
    DateTime.parse(aDayAgo()),
  );
}

String aWeekAgo() {
  return _getDate(7);
}

bool isNotOlderThanAWeek(String date) {
  return DateTime.parse(date).isAfter(
    DateTime.parse(aWeekAgo()),
  );
}

String aMonthAgo() {
  return _getDate(30);
}

bool isNotOlderThanAMonth(String date) {
  return DateTime.parse(date).isAfter(
    DateTime.parse(aMonthAgo()),
  );
}

String aTermAgo() {
  return _getDate(90);
}

bool isNotOlderThanATerm(String date) {
  return DateTime.parse(date).isAfter(
    DateTime.parse(aTermAgo()),
  );
}

String aYearAgo() {
  return _getDate(365);
}

bool isNotOlderThanAYear(String date) {
  return DateTime.parse(date).isAfter(
    DateTime.parse(aYearAgo()),
  );
}

/// Documentation
///
/// [email] : the email string.
///
/// [password] : the password string.
///
/// [passLength] : the minimum length of the password.
///
/// Return [map] containing the following key-value pairs:
///
/// ```
/// map{
/// 'state': true/false,
/// 'message': 'message content'
/// }
/// ```
///
Map<String, dynamic> checkLoginValid(String email, String password,
    {int passLength = 8}) {
  var _map = <String, dynamic>{};
  var errMsg = GetUtils.isEmail(email) ? '' : 'Format email incorrect';
  errMsg += GetUtils.isEmail(email) &&
          GetUtils.isLengthGreaterOrEqual(password, passLength)
      ? ''
      : '\n';
  errMsg += GetUtils.isLengthGreaterOrEqual(password, passLength)
      ? ''
      : 'Mot de passe court, minimum doit être $passLength caractères';

  _map['message'] = errMsg;
  _map['state'] = GetUtils.isEmail(email) &&
      GetUtils.isLengthGreaterOrEqual(password, passLength);
  return _map;
}

class phoneNumberReplace {
  static String replacePlus(String phone) {
    String phone2 = phone.replaceAll('+', "00");
    return phone2;
  }

  static String replacePlusBack(String phone) {
    String phone2 = phone.replaceFirst(RegExp(r'00'), '+');
    return phone2;
  }
}
