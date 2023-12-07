import 'package:choosenumber/constants.dart';
import 'package:choosenumber/res/colors.dart';
import 'package:choosenumber/utils/sizes.dart';
import 'package:flutter/material.dart';

class MyRadioOption<T> extends StatelessWidget {
  const MyRadioOption({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
  });

  final T? groupValue;
  final String label;
  final ValueChanged<T?> onChanged;
  final T value;

  Widget _buildLabel() {
    final bool isSelected = value == groupValue;

    return Container(
      width: getShortSize(100),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(radiusCircular)),
        color: isSelected ? primaryColor : secondaryColor,
      ),

      /*decoration: ShapeDecoration(
          shape: const Rec(
            side: BorderSide(
              color: Colors.black,
            ),
          ),
          color: isSelected ? Colors.teal : Colors.white,
        ),*/
      child: Center(
        child: Text(
          label.toString(),
          style: TextStyle(
            color: isSelected ? Colors.white : primaryColor,
            fontSize: getShortSize(13),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: InkWell(
        onTap: () => onChanged(value),
        splashColor: Colors.teal.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              _buildLabel(),
              //const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
