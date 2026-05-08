import 'package:flutter/material.dart';
import '../templates/login_template.dart';

/// Página de Login do GsVS
/// Conecta a camada de apresentação com a lógica de negócio (controller/provider)
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove o AppBar — a tela é full-bleed
      body: LoginTemplate(
        onLogin: _handleLogin,
        onForgotPassword: () => _handleForgotPassword(context),
      ),
    );
  }

  /// TODO: Substituir pela injeção do AuthController (Riverpod / GetX / BLoC)
  Future<void> _handleLogin(String credential, String password) async {
    // Simula chamada à API Laravel
    await Future.delayed(const Duration(milliseconds: 1200));

    // Exemplo de validação — substituir por AuthRepository.login()
    if (credential == 'admin' && password == '123456') {
      // Navigator.pushReplacementNamed(context, '/home');
      return;
    }

    throw Exception('Credenciais inválidas');
  }

  void _handleForgotPassword(BuildContext context) {
    // TODO: Navegar para tela de recuperação de senha
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidade em desenvolvimento.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
