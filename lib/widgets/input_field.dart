import 'package:eva/themes.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextInputType? keyBoardType;
  final bool obscureText;
  final String formProperty;
  final Map<String, String> formValues;

  const CustomInputField({
    Key? key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.icon,
    this.suffixIcon,
    this.keyBoardType,
    this.obscureText = false,
    required this.formProperty,
    required this.formValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: TextFormField(
        style: TextStyle(color: AppTheme.blackColor),
        autofocus: false,
        initialValue: "",
        textCapitalization: TextCapitalization.words,
        obscureText: obscureText,
        keyboardType: keyBoardType,
        onChanged: (value) {
          formValues[formProperty] = value;
        },
        validator: (value) {
          if (value == null) return "asd";
          return value.isEmpty ? "No debe estar vacio" : null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          helperText: helperText,
          suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
          icon: icon == null ? null : Icon(icon),
        ),
      ),
    );
  }
}
