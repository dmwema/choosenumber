import 'package:flutter/material.dart';

InputDecoration inputDecoration(String label, IconData icon) {
  return InputDecoration(
    /*icon: Icon(
      icon,
      color: Colors.black,
      size: 32.0, /*Color(0xff224597)*/
    ),*/
    labelText: label,
    labelStyle:
        const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.541), fontSize: 18.0),
    hintText: '',
    enabledBorder: OutlineInputBorder(),
    focusedBorder: const OutlineInputBorder(),
    border: const OutlineInputBorder(),
  );
}
