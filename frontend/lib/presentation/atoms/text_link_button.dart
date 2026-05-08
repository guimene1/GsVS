import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

/// Link clicável
class TextLinkButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final TextAlign textAlign;

  const TextLinkButton({
    super.key,
    required this.label,
    this.onPressed,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        label,
        textAlign: textAlign,
        style: AppTextStyles.linkText,
      ),
    );
  }
}
