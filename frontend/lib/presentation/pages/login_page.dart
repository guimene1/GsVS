import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../templates/login_template.dart';
import '/data/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginTemplate(
        onLogin: (credential, password) =>
            _handleLogin(context, credential, password),
        onForgotPassword: () => _handleForgotPassword(context),
      ),
    );
  }

  Future<void> _handleLogin(
    BuildContext context,
    String credential,
    String password,
  ) async {
    final authService = AuthService();
    await authService.login(credential, password);
    if (context.mounted) context.go('/dashboard');
  }

  void _handleForgotPassword(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidade em desenvolvimento.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
