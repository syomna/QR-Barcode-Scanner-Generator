import 'package:flutter/material.dart';
import 'package:scanner/UI/constants/constants.dart';

class CustomBackArrow extends StatelessWidget {
  const CustomBackArrow({Key? key, this.icon , this.color}) : super(key: key);

  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: color ?? kPrimaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Icon(icon ?? Icons.arrow_left_sharp),
      ),
    );
  }
}
