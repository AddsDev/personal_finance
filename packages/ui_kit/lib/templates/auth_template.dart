import 'package:flutter/material.dart';
import '../extension/context_extensions.dart';

class AuthTemplate extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget form;
  final Widget? logo;

  const AuthTemplate({
    super.key,
    required this.title,
    this.subtitle,
    required this.form,
    this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient:
              context.theme.brightness == Brightness.light
                  ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFFE0F2FE), // Light blue
                      const Color(0xFFF0F9FF),
                      context.theme.scaffoldBackgroundColor,
                    ],
                  )
                  : null, // dfault
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                // Web constraint
                constraints: const BoxConstraints(maxWidth: 450),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (logo != null) ...[logo!, const SizedBox(height: 24)],
                    Text(
                      title,
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.theme.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        subtitle!,
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: context.theme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    const SizedBox(height: 40),
                    form,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
