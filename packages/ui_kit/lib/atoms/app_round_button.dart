import 'package:flutter/material.dart';

import '../extension/context_extensions.dart';

class AppRoundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const AppRoundButton({
    super.key,
    required this.onPressed,
    required this.iconData,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: CircleAvatar(
        backgroundColor:
            backgroundColor ?? context.appColors.expense.withAlpha(22),
        foregroundColor: foregroundColor ?? context.appColors.expense,
        child: Icon(iconData, size: 20),
      ),
    );
  }
}
