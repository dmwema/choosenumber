import 'package:choosenumber/res/colors.dart';
import 'package:flutter/material.dart';

class ThemeHelper {
  InputDecoration textInputDecoration(
      [String lableText = "",
      String hintText = "",
      String prefix = "",
      Widget? suffix]) {
    return InputDecoration(
      labelStyle: TextStyle(color: secondaryColor.withOpacity(0.5)),
      prefix: Text(prefix),
      suffix: suffix,
      labelText: lableText,
      hintText: hintText,
      fillColor: primaryBlack,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  InputDecoration textInputDecorationNoborder(
      [String lableText = "", String hintText = "", String prefix = ""]) {
    return InputDecoration(
      labelStyle: TextStyle(color: secondaryColor.withOpacity(0.5)),
      prefix: Text(prefix),
      labelText: lableText,
      hintText: hintText,
      fillColor: primaryBlack,
      filled: true,
      border: InputBorder.none,
    );
  }

  InputDecoration textInputDecorationTrans(
      [String lableText = "", String hintText = "", String prefix = ""]) {
    return InputDecoration(
      labelStyle: TextStyle(color: secondaryColor.withOpacity(0.5)),
      prefix: Text(prefix),
      labelText: lableText,
      hintText: hintText,
      fillColor: Colors.transparent,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: primaryColor)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: primaryColor)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  BoxDecoration inputBoxDecorationShaddow() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: primaryBlack.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 5),
      )
    ]);
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(50, 50)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  ButtonStyle buttonStyleBorder(Color color) {
    return ButtonStyle(
      side: MaterialStateProperty.all(
          BorderSide(color: color, width: 2.0, style: BorderStyle.solid)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(40, 40)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  ButtonStyle buttonStyle2(Color color) {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(40, 40)),
      backgroundColor: MaterialStateProperty.all(color),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  AlertDialog alartDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class LoginFormStyle {}
