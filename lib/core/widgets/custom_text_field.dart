import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.keyboardType,
    this.onChanged,
    this.onSaved,
    this.maxLines,
    this.icon,
    this.suffixIcon,
    this.controller,
    this.textInputAction,
    this.labelText,
    this.obscureText = false,
  });

  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final int? maxLines;
  final IconData? icon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String? labelText;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines,
      textInputAction: textInputAction,
      obscureText: obscureText!,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, size: 20, color: colors.onSurfaceVariant),
        suffixIcon: suffixIcon,
        fillColor: colors.surface,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.outline),
        ),
      ),
    );
  }
}
