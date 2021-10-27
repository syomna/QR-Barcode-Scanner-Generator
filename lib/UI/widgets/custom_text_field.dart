import 'package:flutter/material.dart';
import 'package:scanner/UI/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.hint,
  required this.prefixIcon,
   required this.onChanged})
      : super(key: key);

  final String hint;
  final IconData prefixIcon;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon , color: kPrimaryColor,),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: kPrimaryColor))),
    );
  }
}
