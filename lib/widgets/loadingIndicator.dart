import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../res/colors.dart';

class LoadingIndicator extends StatelessWidget {
  String text;
  LoadingIndicator({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return  Card(
       elevation: 2,
        child:Container(
          width: MediaQuery.of(context).size.width/2,
          padding: const EdgeInsets.all(5),
          child:ListTile(
            leading:const CupertinoActivityIndicator(
        color: primaryColor,
      ), title:Text(text))));
  }
}