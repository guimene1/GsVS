/// Modelo dos dados do Dashboard
/// GET /api/dashboard/stats
class DashboardStatsModel {
  final int solicitacoesHoje;
  final int emAnalise;
  final int aprovadas;
  final int rejeitadas;
  final double variacaoSolicitacoesHoje; // % em relação a ontem
  final double variacaoEmAnalise;
  final double variacaoAprovadas;
  final double variacaoRejeitadas;
  final int totalGeral;
  final int concluidas;
  final List<MonthlyDataPoint> solicitacoesPorMes;
  final List<RecentSolicitacao> solicitacoesRecentes;

  const DashboardStatsModel({
    required this.solicitacoesHoje,
    required this.emAnalise,
    required this.aprovadas,
    required this.rejeitadas,
    required this.variacaoSolicitacoesHoje,
    required this.variacaoEmAnalise,
    required this.variacaoAprovadas,
    required this.variacaoRejeitadas,
    required this.totalGeral,
    required this.concluidas,
    required this.solicitacoesPorMes,
    required this.solicitacoesRecentes,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) =>
      DashboardStatsModel(
        solicitacoesHoje: json['solicitacoes_hoje'] as int,
        emAnalise: json['em_analise'] as int,
        aprovadas: json['aprovadas'] as int,
        rejeitadas: json['rejeitadas'] as int,
        variacaoSolicitacoesHoje:
            (json['variacao_solicitacoes_hoje'] as num).toDouble(),
        variacaoEmAnalise: (json['variacao_em_analise'] as num).toDouble(),
        variacaoAprovadas: (json['variacao_aprovadas'] as num).toDouble(),
        variacaoRejeitadas: (json['variacao_rejeitadas'] as num).toDouble(),
        totalGeral: json['total_geral'] as int,
        concluidas: json['concluidas'] as int,
        solicitacoesPorMes: (json['solicitacoes_por_mes'] as List)
            .map((e) => MonthlyDataPoint.fromJson(e as Map<String, dynamic>))
            .toList(),
        solicitacoesRecentes: (json['solicitacoes_recentes'] as List)
            .map((e) => RecentSolicitacao.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  /// Stub para desenvolvimento sem backend
  static DashboardStatsModel get stub => DashboardStatsModel(
        solicitacoesHoje: 120,
        emAnalise: 35,
        aprovadas: 80,
        rejeitadas: 5,
        variacaoSolicitacoesHoje: 12,
        variacaoEmAnalise: 8,
        variacaoAprovadas: 15,
        variacaoRejeitadas: -20,
        totalGeral: 240,
        concluidas: 120,
        solicitacoesPorMes: [
          MonthlyDataPoint('Jan', 60),
          MonthlyDataPoint('Fev', 75),
          MonthlyDataPoint('Mar', 90),
          MonthlyDataPoint('Abr', 85),
          MonthlyDataPoint('Mai', 110),
          MonthlyDataPoint('Jun', 150),
          MonthlyDataPoint('Jul', 95),
          MonthlyDataPoint('Ago', 100),
          MonthlyDataPoint('Set', 88),
          MonthlyDataPoint('Out', 105),
          MonthlyDataPoint('Nov', 98),
          MonthlyDataPoint('Dez', 120),
        ],
        solicitacoesRecentes: [
          RecentSolicitacao(
            id: '#2405',
            solicitante: 'Marcos Carvalho',
            cargo: 'Motorista',
            destino: 'Curitiba - PR',
            local: 'Hospital das Clínicas',
            dataViagem: '22/05/2024',
            horario: '06:00',
            status: SolicitacaoStatus.emAnalise,
          ),
          RecentSolicitacao(
            id: '#2404',
            solicitante: 'Ana Souza',
            cargo: 'Enfermeira',
            destino: 'Ponta Grossa - PR',
            local: 'Laboratório Central',
            dataViagem: '21/05/2024',
            horario: '07:30',
            status: SolicitacaoStatus.aprovada,
          ),
          RecentSolicitacao(
            id: '#2403',
            solicitante: 'João Ribeiro',
            cargo: 'Médico',
            destino: 'Londrina - PR',
            local: 'Hospital Universitário',
            dataViagem: '20/05/2024',
            horario: '06:00',
            status: SolicitacaoStatus.emAnalise,
          ),
          RecentSolicitacao(
            id: '#2402',
            solicitante: 'Fernanda Lima',
            cargo: 'Técnica em Saúde',
            destino: 'Curitiba - PR',
            local: 'SESA',
            dataViagem: '19/05/2024',
            horario: '09:00',
            status: SolicitacaoStatus.aprovada,
          ),
          RecentSolicitacao(
            id: '#2401',
            solicitante: 'Roberto Paulo',
            cargo: 'Motorista',
            destino: 'Guarapuava - PR',
            local: 'Unidade de Saúde',
            dataViagem: '18/05/2024',
            horario: '08:30',
            status: SolicitacaoStatus.rejeitada,
          ),
        ],
      );
}

class MonthlyDataPoint {
  final String month;
  final int value;
  const MonthlyDataPoint(this.month, this.value);

  factory MonthlyDataPoint.fromJson(Map<String, dynamic> json) =>
      MonthlyDataPoint(json['month'] as String, json['value'] as int);
}

enum SolicitacaoStatus {
  emAnalise('Em análise'),
  aprovada('Aprovada'),
  rejeitada('Rejeitada'),
  concluida('Concluída'),
  enviada('Enviada'),
  processando('Em processamento'),
  paga('Paga'),
  finalizada('Finalizada');

  const SolicitacaoStatus(this.label);
  final String label;

  static SolicitacaoStatus fromString(String value) =>
      SolicitacaoStatus.values.firstWhere(
        (s) => s.label.toLowerCase() == value.toLowerCase(),
        orElse: () => SolicitacaoStatus.enviada,
      );
}

class RecentSolicitacao {
  final String id;
  final String solicitante;
  final String cargo;
  final String destino;
  final String local;
  final String dataViagem;
  final String horario;
  final SolicitacaoStatus status;

  String get initials {
    final parts = solicitante.trim().split(' ');
    if (parts.length >= 2) return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    return parts.first.substring(0, 2).toUpperCase();
  }

  const RecentSolicitacao({
    required this.id,
    required this.solicitante,
    required this.cargo,
    required this.destino,
    required this.local,
    required this.dataViagem,
    required this.horario,
    required this.status,
  });

  factory RecentSolicitacao.fromJson(Map<String, dynamic> json) =>
      RecentSolicitacao(
        id: json['id'] as String,
        solicitante: json['solicitante'] as String,
        cargo: json['cargo'] as String,
        destino: json['destino'] as String,
        local: json['local'] as String,
        dataViagem: json['data_viagem'] as String,
        horario: json['horario'] as String,
        status: SolicitacaoStatus.fromString(json['status'] as String),
      );
}
