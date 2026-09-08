import 'package:flutter/material.dart';

class CustomAddTaskField extends StatelessWidget {
  const CustomAddTaskField({
    super.key,
    this.controller,
    this.validator,
    this.readOnly = true,
    this.maxLine = 1,
    this.suffixIcon = null,
    required this.hintText,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final int maxLine;
  final Widget? suffixIcon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly ?? false,
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'This field cannot be empty';
            }
          },

      maxLines: maxLine,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,

        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff4e5ae8)),
        ),
      ),
    );
  }
}
