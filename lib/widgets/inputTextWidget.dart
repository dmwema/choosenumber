import 'package:choosenumber/res/colors.dart';
import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool obscureText;
  final keyboardType;
  final controller;
  final bool readOnly;
  final String prefix;
  final Widget? suffix;
  String? Function(String?)? validator;

  InputTextWidget(
      {super.key,
      required this.labelText,
      required this.icon,
      required this.obscureText,
      required this.keyboardType,
      this.controller,
      this.readOnly = false,
      this.prefix = "",
      this.suffix,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Container(
        child: Material(
          elevation: 3.0,
          shadowColor: primaryColor,
          borderRadius: BorderRadius.circular(15.0),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 15.0),
            child: TextFormField(
                controller: controller,
                obscureText: obscureText,
                autofocus: false,
                keyboardType: keyboardType,
                readOnly: readOnly,
                decoration: InputDecoration(
                  prefix: Text(prefix),
                  suffix: suffix,
                  icon: Icon(
                    icon,
                    color: primaryColor,
                    size: 30.0, /*Color(0xff224597)*/
                  ),
                  labelText: labelText,
                  labelStyle:
                      const TextStyle(color: Colors.black54, fontSize: 18.0),
                  hintText: '',
                  enabledBorder: InputBorder.none,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  border: InputBorder.none,
                ),
                validator: validator),
          ),
        ),
      ),
    );
  }
}
