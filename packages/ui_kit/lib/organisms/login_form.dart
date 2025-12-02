import 'package:flutter/material.dart';

import '../atoms/app_button.dart';
import '../atoms/app_input.dart';
import '../extension/context_extensions.dart';
import '../validators/app_validator.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final VoidCallback onRegisterLinkTap;
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
    required this.onRegisterLinkTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppInput(
          label: 'Correo electrónico',
          hint: 'ejemplo@correo.com',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.email_outlined,
          validator: AppValidators.email,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        AppInput(
          label: 'Contraseña',
          hint: '••••••••',
          isPassword: true,
          controller: passwordController,
          prefixIcon: Icons.lock_outline,
          textInputAction: TextInputAction.send,
        ),
        const SizedBox(height: 32),
        AppButton(
          text: 'Iniciar Sesión',
          onPressed: onLogin,
          isLoading: isLoading,
        ),
        const SizedBox(height: 24),
        _buildFooterLink(
          context,
          '¿No tienes una cuenta?',
          'Registrarse',
          onRegisterLinkTap,
        ),
      ],
    );
  }

  Widget _buildFooterLink(
    BuildContext context,
    String text,
    String linkText,
    VoidCallback onTap,
  ) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            text: '$text ',
            style: context.textTheme.bodyMedium,
            children: [
              TextSpan(
                text: linkText,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
