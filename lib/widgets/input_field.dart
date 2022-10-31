import 'package:eva/themes.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextInputType? keyBoardType;
  final bool obscureText;
  final bool enabled;
  final String formProperty;
  final Map<String, dynamic> formValues;
  final bool? validate;

  const CustomInputField({
    Key? key,
    this.hintText,
    this.initialValue,
    this.labelText,
    this.helperText,
    this.icon,
    this.suffixIcon,
    this.keyBoardType,
    this.validate,
    this.obscureText = false,
    this.enabled = true,
    required this.formProperty,
    required this.formValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 500,
        child: TextFormField(
          enabled: enabled,
          style: TextStyle(color: Colors.white),
          autofocus: false,
          initialValue: initialValue,
          textCapitalization: TextCapitalization.words,
          obscureText: obscureText,
          keyboardType: keyBoardType,
          onChanged: (value) {
            formValues[formProperty] = value;
          },
          validator: validate == false
              ? null
              : (value) {
                  if (value == null) return "asd";
                  return value.isEmpty ? "No debe estar vacio" : null;
                },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            alignLabelWithHint: false,
            labelStyle: const TextStyle(color: Colors.white),
            floatingLabelStyle: const TextStyle(color: Colors.white),
            helperText: helperText,
            suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
            icon: icon == null ? null : Icon(icon),
            filled: true,
            fillColor: AppTheme.blackLightColor,
          ),
        ));
  }
}
