import 'package:flutter/material.dart';
import '../../../data/models/dashboard_stats_model.dart';

/// Átomo: Badge colorido de status de solicitação
class StatusBadge extends StatelessWidget {
  final SolicitacaoStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _statusConfig[status]!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: config.bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: config.text,
        ),
      ),
    );
  }

  static final _statusConfig = {
    SolicitacaoStatus.emAnalise: _BadgeConfig(
      bg: const Color(0xFFFFF7E6),
      text: const Color(0xFFB45309),
    ),
    SolicitacaoStatus.aprovada: _BadgeConfig(
      bg: const Color(0xFFECFDF5),
      text: const Color(0xFF065F46),
    ),
    SolicitacaoStatus.rejeitada: _BadgeConfig(
      bg: const Color(0xFFFEF2F2),
      text: const Color(0xFF991B1B),
    ),
    SolicitacaoStatus.concluida: _BadgeConfig(
      bg: const Color(0xFFEFF6FF),
      text: const Color(0xFF1D4ED8),
    ),
    SolicitacaoStatus.enviada: _BadgeConfig(
      bg: const Color(0xFFF3F4F6),
      text: const Color(0xFF374151),
    ),
    SolicitacaoStatus.processando: _BadgeConfig(
      bg: const Color(0xFFF5F3FF),
      text: const Color(0xFF5B21B6),
    ),
    SolicitacaoStatus.paga: _BadgeConfig(
      bg: const Color(0xFFECFDF5),
      text: const Color(0xFF065F46),
    ),
    SolicitacaoStatus.finalizada: _BadgeConfig(
      bg: const Color(0xFFF3F4F6),
      text: const Color(0xFF374151),
    ),
  };
}

class _BadgeConfig {
  final Color bg;
  final Color text;
  const _BadgeConfig({required this.bg, required this.text});
}
