import 'package:choosenumber/res/colors.dart';
import 'package:choosenumber/widgets/text_styled.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color bgColor;
  const SubmitButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 0.0,
          minimumSize: Size(MediaQuery.of(context).size.width, 150),
          padding: const EdgeInsets.symmetric(horizontal: 25),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
              color: bgColor, // Color(0xffF05945),
              borderRadius: BorderRadius.circular(7.0)),
          child: Container(
            alignment: Alignment.center,
            child: textStyled(text, 18, primaryColor, primaryColor),
          ),
        ),
      ),
    );
  }
}
