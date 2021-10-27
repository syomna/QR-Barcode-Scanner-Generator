import 'package:flutter/material.dart';
import 'package:scanner/UI/constants/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key, required this.text, this.color, required this.onPressed})
      : super(key: key);

  final String text;
  final Color? color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(color ?? kPrimaryColor),
          ),
          onPressed: onPressed,
          child: Text(text)),
    );
  }
}
