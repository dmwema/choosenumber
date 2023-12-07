import 'package:choosenumber/res/colors.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class CardOption extends StatelessWidget {
  final Widget row;
  final String textheader;
  const CardOption({Key? key, required this.row, required this.textheader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0.5,
      color: secondaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              padding: EdgeInsets.all(7),
              width: double.infinity,
              child: Text(textheader,
                  style: const TextStyle(
                    color: primaryWhite,
                    fontFamily: 'Segoe UI',
                    fontSize: 18,
                    shadows: [
                      Shadow(
                        color: Color(0xba000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      )
                    ],
                  ))),
          row,
        ],
      ),
    );
  }
}
