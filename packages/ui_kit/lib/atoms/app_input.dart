import 'package:flutter/material.dart';
import '../extension/context_extensions.dart';

class AppInput extends StatelessWidget {
  final String label;
  final String? hint;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autovalidateMode;
  final ValueChanged<String>? onChanged;

  const AppInput({
    super.key,
    required this.label,
    this.hint,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.textInputAction = TextInputAction.next,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface.withAlpha(204),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          validator: validator,
          keyboardType: keyboardType,
          style: context.textTheme.bodyLarge,
          textInputAction: textInputAction,
          autovalidateMode: autovalidateMode,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
