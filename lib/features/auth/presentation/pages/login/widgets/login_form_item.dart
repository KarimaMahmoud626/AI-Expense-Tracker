import 'package:ai_expense_tracker/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginFormItem extends StatelessWidget {
  const LoginFormItem({
    super.key,
    required this.text,
    this.keyboardType,
    this.maxLines,
    this.onChanged,
    this.onSaved,
    this.icon,
    this.validator,
    this.suffixIcon,
    this.controller,
    this.textInputAction,
    this.obscureText = false,
  });

  final String text;
  final TextInputType? keyboardType;
  final int? maxLines;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final IconData? icon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          labelText: text,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onSaved: onSaved,
          onChanged: onChanged,
          icon: icon,
          suffixIcon: suffixIcon,
          controller: controller,
          textInputAction: textInputAction,
          obscureText: obscureText,
        ),
      ],
    );
  }
}
