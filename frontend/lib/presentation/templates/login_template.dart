import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../molecules/logo_card.dart';
import '../organisms/login_form_card.dart';

/// layout de tela de login
class LoginTemplate extends StatelessWidget {
  final Future<void> Function(String credential, String password)? onLogin;
  final VoidCallback? onForgotPassword;

  const LoginTemplate({
    super.key,
    this.onLogin,
    this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= AppConstants.tabletBreakpoint;

        return isDesktop
            ? _buildDesktopLayout(context)
            : _buildMobileLayout(context);
      },
    );
  }

  // layout para telas menores
  Widget _buildMobileLayout(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingLg,
            vertical: AppConstants.spacingXl,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppConstants.loginCardMaxWidth,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: AppConstants.spacingMd),
                  const LogoCard(),
                  const SizedBox(height: AppConstants.spacingXl),
                  LoginFormCard(
                    onLogin: onLogin,
                    onForgotPassword: onForgotPassword,
                  ),
                  const SizedBox(height: AppConstants.spacingXl),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // layout para telas maiores
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        // painel de branding
        Expanded(
          flex: 5,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary,
                  AppColors.primaryDark,
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDesktopBranding(),
                  const SizedBox(height: 48),
                  _buildDesktopFeatures(),
                ],
              ),
            ),
          ),
        ),

        // painel de login
        Expanded(
          flex: 4,
          child: Container(
            color: AppColors.background,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingXxl,
                  vertical: AppConstants.spacingXxl,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: AppConstants.loginCardMaxWidth,
                      ),
                      child: LoginFormCard(
                        onLogin: onLogin,
                        onForgotPassword: onForgotPassword,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingLg),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopBranding() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Gs',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -2,
                  ),
                ),
                TextSpan(
                  text: 'VS',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF93C5FD),
                    letterSpacing: -2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Sistema Web para Gestão de\nViagens à Serviço',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopFeatures() {
    final features = [
      (Icons.assignment_outlined, 'Solicitações digitais de ajuda de custo'),
      (Icons.verified_user_outlined, 'Fluxo de aprovação hierárquico'),
      (Icons.picture_as_pdf_outlined, 'Documentos com hash SHA-256'),
      (Icons.wifi_off_rounded, 'Modo offline com sincronização'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        children: features
            .map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(f.$1, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        f.$2,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildFooter() {
    return Text(
      '© 2025 GsVS — Prefeitura de Prudentópolis',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 12,
        color: AppColors.textSecondary,
      ),
    );
  }
}
