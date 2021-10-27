import 'package:flutter/material.dart';
import 'package:scanner/UI/constants/constants.dart';

class ControllerButton extends StatelessWidget {
  const ControllerButton({Key? key, required this.icon, required this.onTap})
      : super(key: key);

  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
        child: Icon(
          icon,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
