import 'package:flutter/material.dart';

/// Átomo: Indicador de variação percentual (↑ 12% / ↓ 5%)
class TrendIndicator extends StatelessWidget {
  final double value;
  final String suffix;

  const TrendIndicator({
    super.key,
    required this.value,
    this.suffix = 'em relação a ontem',
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = value >= 0;
    final color = isPositive ? const Color(0xFF16A34A) : const Color(0xFFDC2626);
    final icon = isPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded;
    final sign = isPositive ? '+' : '';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 2),
        Text(
          '$sign${value.abs().toStringAsFixed(0)}% $suffix',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}
