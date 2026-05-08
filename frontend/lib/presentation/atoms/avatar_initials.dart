import 'package:flutter/material.dart';

/// Átomo: Avatar circular com iniciais do usuário
class AvatarInitials extends StatelessWidget {
  final String initials;
  final Color? backgroundColor;
  final double size;
  final double fontSize;

  const AvatarInitials({
    super.key,
    required this.initials,
    this.backgroundColor,
    this.size = 36,
    this.fontSize = 13,
  });

  static const _colors = [
    Color(0xFF1B3A8C),
    Color(0xFF0891B2),
    Color(0xFF059669),
    Color(0xFFD97706),
    Color(0xFFDC2626),
    Color(0xFF7C3AED),
    Color(0xFFDB2777),
    Color(0xFF0284C7),
  ];

  Color _colorFromInitials() {
    final code = initials.isEmpty ? 0 : initials.codeUnitAt(0);
    return _colors[code % _colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? _colorFromInitials(),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
