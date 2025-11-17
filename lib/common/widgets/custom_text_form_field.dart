import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? label;
  final String? hintText;
  final bool isObscure;
  final VoidCallback? callBack;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.label,
    this.hintText,
    this.isObscure = false,
    this.callBack,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: callBack,
      controller: controller,
      obscureText: isObscure,

      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        label: label,
      ),
    );
  }
}
