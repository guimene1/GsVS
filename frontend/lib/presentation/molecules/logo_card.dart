import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../atoms/app_logo_text.dart';

/// Card com logo e subtítulo 
class LogoCard extends StatelessWidget {
  final double? maxWidth;

  const LogoCard({super.key, this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? AppConstants.logoCardMaxWidth,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingXl,
        vertical: AppConstants.spacingLg,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppLogoText(),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            'Sistema Web para Gestão de\nViagens à Serviço',
            textAlign: TextAlign.center,
            style: AppTextStyles.logoSubtitle,
          ),
        ],
      ),
    );
  }
}
