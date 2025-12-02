import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/extension/context_extensions.dart';
import 'package:ui_kit/organisms/login_form.dart';
import 'package:ui_kit/templates/auth_template.dart';

import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onRegisterTap;

  const LoginPage({super.key, required this.onRegisterTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        AuthLoginRequested(_emailController.text, _passwordController.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: context.theme.colorScheme.error,
              ),
            );
          }
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: context.theme.colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return AuthTemplate(
          title: 'Finanzas Fácil',
          subtitle: 'Inicio de Sesión',
          logo: const Icon(
            Icons.account_balance_wallet,
            size: 60,
            color: Colors.blue,
          ),
          form: Form(
            key: _formKey,
            child: LoginForm(
              emailController: _emailController,
              passwordController: _passwordController,
              isLoading: state.isLoading,
              onLogin: _onLoginPressed,
              onRegisterLinkTap: widget.onRegisterTap,
            ),
          ),
        );
      },
    );
  }
}
