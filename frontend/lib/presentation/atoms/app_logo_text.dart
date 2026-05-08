import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// logo textual
class AppLogoText extends StatelessWidget {
  final double? fontSize;

  const AppLogoText({super.key, this.fontSize});

  @override
  Widget build(BuildContext context) {
    final size = fontSize ?? 40;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Gs',
            style: AppTextStyles.logoTitle.copyWith(
              fontSize: size,
              color: AppColors.primary,
            ),
          ),
          TextSpan(
            text: 'VS',
            style: AppTextStyles.logoTitle.copyWith(
              fontSize: size,
              color: AppColors.primaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
