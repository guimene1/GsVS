import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/models/user_model.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/dashboard/dashboard_page.dart';

/// Rotas nomeadas do GsVS
abstract class AppRoutes {
  static const login = '/';
  static const dashboard = '/dashboard';
  static const usuarios = '/usuarios';
  static const solicitacoes = '/solicitacoes';
  static const viagens = '/viagens';
  static const veiculos = '/veiculos';
  static const motoristas = '/motoristas';
  static const unidades = '/unidades';
  static const relatorios = '/relatorios';
  static const logs = '/logs';
  static const configuracoes = '/configuracoes';
}

/// Instância do GoRouter
/// TODO: Substituir _isLoggedIn pela verificação real do token (SecureStorage)
/// TODO: Adicionar redirect por perfil: redirect: _roleGuard
GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppRoutes.dashboard, // trocar para login após auth
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // TODO: Implementar guard de autenticação
      // final isLoggedIn = AuthService.instance.isLoggedIn;
      // if (!isLoggedIn && state.matchedLocation != AppRoutes.login) {
      //   return AppRoutes.login;
      // }
      return null; // sem redirect por enquanto
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LoginPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        name: 'dashboard',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: DashboardPage(),
        ),
      ),

      // ── Rotas futuras ─────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.usuarios,
        name: 'usuarios',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: _PlaceholderPage(title: 'Usuários'),
        ),
      ),
      GoRoute(
        path: AppRoutes.solicitacoes,
        name: 'solicitacoes',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: _PlaceholderPage(title: 'Solicitações'),
        ),
      ),
      GoRoute(
        path: AppRoutes.viagens,
        name: 'viagens',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: _PlaceholderPage(title: 'Viagens'),
        ),
      ),
      GoRoute(
        path: AppRoutes.veiculos,
        name: 'veiculos',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: _PlaceholderPage(title: 'Veículos'),
        ),
      ),
      GoRoute(
        path: AppRoutes.motoristas,
        name: 'motoristas',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: _PlaceholderPage(title: 'Motoristas'),
        ),
      ),
      GoRoute(
        path: AppRoutes.unidades,
        name: 'unidades',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: _PlaceholderPage(title: 'Unidades'),
        ),
      ),
      GoRoute(
        path: AppRoutes.relatorios,
        name: 'relatorios',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: _PlaceholderPage(title: 'Relatórios'),
        ),
      ),
      GoRoute(
        path: AppRoutes.logs,
        name: 'logs',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: _PlaceholderPage(title: 'Logs do Sistema'),
        ),
      ),
      GoRoute(
        path: AppRoutes.configuracoes,
        name: 'configuracoes',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: _PlaceholderPage(title: 'Configurações'),
        ),
      ),
    ],
  );
}

/// Página placeholder para rotas ainda não implementadas
class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.construction_rounded, size: 64, color: Color(0xFF1B3A8C)),
            const SizedBox(height: 16),
            Text(title,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F1F4D))),
            const SizedBox(height: 8),
            const Text('Página em desenvolvimento',
                style: TextStyle(color: Color(0xFF6B7280))),
          ],
        ),
      ),
    );
  }
}
