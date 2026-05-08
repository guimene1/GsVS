import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

/// Rótulo de campo de formulário
class FieldLabel extends StatelessWidget {
  final String text;
  final bool required;

  const FieldLabel({
    super.key,
    required this.text,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingSm),
      child: Row(
        children: [
          Text(text, style: AppTextStyles.label),
          if (required)
            const Text(
              ' *',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFFDC2626),
              ),
            ),
        ],
      ),
    );
  }
}
