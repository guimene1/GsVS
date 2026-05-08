import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/dashboard_stats_model.dart';
import '../../../data/repositories/dashboard_repository.dart';
import '../../templates/dashboard_template.dart';

/// Página do Dashboard
/// Responsável por buscar dados e repassar ao template
/// TODO: Substituir StatefulWidget por Riverpod/BLoC quando adicionar DI
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // TODO: Injetar via Riverpod/Provider
  final _repository = DashboardRepositoryImpl();

  // TODO: Buscar usuário autenticado do AuthService/SecureStorage
  final _user = UserModel.stub;

  DashboardStatsModel? _stats;
  bool _isLoading = true;
  String? _error;
  int _selectedYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final stats = await _repository.getStats(year: _selectedYear);
      if (mounted) setState(() => _stats = stats);
    } catch (e) {
      if (mounted) setState(() => _error = 'Erro ao carregar dados. Tente novamente.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _onYearChanged(int year) {
    setState(() => _selectedYear = year);
    _loadStats();
  }

  @override
  Widget build(BuildContext context) {
    // Erro crítico: fallback
    if (_error != null && _stats == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off_rounded, size: 48, color: Color(0xFF9CA3AF)),
              const SizedBox(height: 16),
              Text(_error!,
                  style: const TextStyle(color: Color(0xFF6B7280))),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _loadStats,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Tentar novamente'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B3A8C)),
              ),
            ],
          ),
        ),
      );
    }

    return DashboardTemplate(
      user: _user,
      isLoading: _isLoading && _stats == null,
    );
  }
}
