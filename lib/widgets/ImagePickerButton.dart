import 'package:flutter/material.dart';

class ImagePickerButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  final String label;
  const ImagePickerButton({Key? key, required this.onPressed, required this.iconData, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
        child:Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Container(
        child: Material(
          elevation: 15.0,
          shadowColor: Colors.black,
          borderRadius: BorderRadius.circular(15.0),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 15.0),
            child: Container(
              child:ListTile(
                leading: Icon(iconData),
                title: Text(label),
              )
            ),
          ),
        ),
      ),
    ));
  }
}
