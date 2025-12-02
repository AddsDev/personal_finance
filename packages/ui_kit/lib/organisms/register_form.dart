import 'package:flutter/material.dart';

import '../atoms/app_button.dart';
import '../atoms/app_input.dart';
import '../extension/context_extensions.dart';
import '../validators/app_validator.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onRegister;
  final VoidCallback onLoginLinkTap;
  final bool isLoading;

  const RegisterForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onRegister,
    required this.onLoginLinkTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppInput(
          label: 'Nombre completo',
          controller: nameController,
          prefixIcon: Icons.person_outline,
        ),
        const SizedBox(height: 16),
        AppInput(
          label: 'Correo electrónico',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.email_outlined,
          validator: AppValidators.email,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        const SizedBox(height: 16),
        AppInput(
          label: 'Contraseña',
          isPassword: true,
          controller: passwordController,
          prefixIcon: Icons.lock_outline,
          validator: (value) => AppValidators.password(value?.trim()),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        const SizedBox(height: 16),
        AppInput(
          label: 'Confirmar contraseña',
          isPassword: true,
          controller: confirmPasswordController,
          prefixIcon: Icons.lock_outline,
          validator: (value) => AppValidators.password(value?.trim()),
          textInputAction: TextInputAction.send,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        const SizedBox(height: 32),
        AppButton(
          text: 'Registrarse',
          onPressed: onRegister,
          isLoading: isLoading,
        ),
        const SizedBox(height: 24),
        Center(
          child: GestureDetector(
            onTap: onLoginLinkTap,
            child: RichText(
              text: TextSpan(
                text: '¿Ya tienes cuenta? ',
                style: context.textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: 'Iniciar sesión',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
