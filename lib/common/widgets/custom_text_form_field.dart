import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? label;
  final String? hintText;
  final bool isObscure;
  final VoidCallback? callBack;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.label,
    this.hintText,
    this.isObscure = false,
    this.callBack,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: callBack,
      controller: controller,
      obscureText: isObscure,
      validator: validator,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,

      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        label: label,
      ),
    );
  }
}
