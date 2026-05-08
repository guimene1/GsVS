import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../atoms/primary_button.dart';
import '../atoms/text_link_button.dart';
import '../molecules/labeled_text_field.dart';
import '../molecules/password_text_field.dart';

/// card de formulário de login
class LoginFormCard extends StatefulWidget {
  final Future<void> Function(String credential, String password)? onLogin;
  final VoidCallback? onForgotPassword;

  const LoginFormCard({
    super.key,
    this.onLogin,
    this.onForgotPassword,
  });

  @override
  State<LoginFormCard> createState() => _LoginFormCardState();
}

class _LoginFormCardState extends State<LoginFormCard> {
  final _formKey = GlobalKey<FormState>();
  final _credentialController = TextEditingController();
  final _passwordController = TextEditingController();
  final _credentialFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _credentialController.dispose();
    _passwordController.dispose();
    _credentialFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  String? _validateCredential(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe seu CPF ou e-mail';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe sua senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  Future<void> _handleLogin() async {
    setState(() => _errorMessage = null);

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await widget.onLogin?.call(
        _credentialController.text.trim(),
        _passwordController.text,
      );
    } catch (e) {
      setState(() => _errorMessage = 'Credenciais inválidas. Tente novamente.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingXl),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusXl),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header do card
            const SizedBox(height: AppConstants.spacingMd),
            Text(
              'Acesse sua conta',
              style: AppTextStyles.headingLarge,
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              'Entre com suas credenciais para acessar o sistema.',
              style: AppTextStyles.bodyRegular,
            ),
            const SizedBox(height: AppConstants.spacingXl),

            // Campo cpf ou email
            LabeledTextField(
              label: 'CPF ou E-mail',
              hintText: 'Digite seu CPF ou e-mail',
              prefixIcon: Icons.person_outline_rounded,
              controller: _credentialController,
              keyboardType: TextInputType.emailAddress,
              validator: _validateCredential,
              textInputAction: TextInputAction.next,
              focusNode: _credentialFocus,
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocus);
              },
            ),
            const SizedBox(height: AppConstants.spacingLg),

            // Campo senha
            PasswordTextField(
              controller: _passwordController,
              validator: _validatePassword,
              textInputAction: TextInputAction.done,
              focusNode: _passwordFocus,
              onSubmitted: (_) => _handleLogin(),
            ),
            const SizedBox(height: AppConstants.spacingMd),

            //erro
            if (_errorMessage != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                  border: Border.all(color: const Color(0xFFFCA5A5)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      color: Color(0xFFDC2626),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFFDC2626),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.spacingMd),
            ],

            //Link esqueci minha senha
            Align(
              alignment: Alignment.centerRight,
              child: TextLinkButton(
                label: 'Esqueci minha senha',
                onPressed: widget.onForgotPassword,
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(height: AppConstants.spacingXl),

            //botão de login
            PrimaryButton(
              label: 'Entrar',
              icon: Icons.login_rounded,
              onPressed: _handleLogin,
              isLoading: _isLoading,
            ),
            const SizedBox(height: AppConstants.spacingMd),
          ],
        ),
      ),
    );
  }
}
