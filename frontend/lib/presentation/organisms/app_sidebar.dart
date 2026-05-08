import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/user_model.dart';
import '../atoms/app_logo_text.dart';
import '../atoms/avatar_initials.dart';
import '../molecules/sidebar_nav_item.dart';
import '../../router/app_router.dart';

/// Organismo: Sidebar de navegação do sistema
class AppSidebar extends StatefulWidget {
  final UserModel user;
  final String currentRoute;

  const AppSidebar({super.key, required this.user, required this.currentRoute});

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  bool _isCollapsed = false;

  static const _navItems = [
    _NavItem(Icons.dashboard_rounded, 'Dashboard', AppRoutes.dashboard),
    _NavItem(Icons.people_alt_rounded, 'Usuários', AppRoutes.usuarios),
    _NavItem(Icons.assignment_rounded, 'Solicitações', AppRoutes.solicitacoes),
    _NavItem(Icons.flight_takeoff_rounded, 'Viagens', AppRoutes.viagens),
    _NavItem(Icons.directions_car_rounded, 'Veículos', AppRoutes.veiculos),
    _NavItem(Icons.person_pin_rounded, 'Motoristas', AppRoutes.motoristas),
    _NavItem(Icons.business_rounded, 'Unidades', AppRoutes.unidades),
    _NavItem(Icons.bar_chart_rounded, 'Relatórios', AppRoutes.relatorios),
    _NavItem(Icons.receipt_long_rounded, 'Logs do Sistema', AppRoutes.logs),
    _NavItem(Icons.settings_rounded, 'Configurações', AppRoutes.configuracoes),
  ];

  @override
  Widget build(BuildContext context) {
    final collapsed = _isCollapsed;
    final w = collapsed ? 70.0 : 210.0;
    return Material(
      color: AppColors.primary,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        width: w,
        color: AppColors.primary,
        child: Column(
          children: [
            // ── Logo ──────────────────────────────────────────────────────────
            _buildLogoSection(collapsed),

            // ── Role label ────────────────────────────────────────────────────
            if (!collapsed)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.user.role.label.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withOpacity(0.5),
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

            // ── Nav items ─────────────────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 4, bottom: 8),
                children: _navItems.map((item) {
                  return SidebarNavItem(
                    icon: item.icon,
                    label: item.label,
                    isActive: widget.currentRoute == item.route,
                    isCollapsed: collapsed,
                    onTap: () => context.go(item.route),
                  );
                }).toList(),
              ),
            ),

            // ── Suporte ───────────────────────────────────────────────────────
            if (!collapsed) _buildSupportBox(),

            const Divider(color: Colors.white24, height: 1),

            // ── Collapse toggle ───────────────────────────────────────────────
            _buildCollapseButton(collapsed),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoSection(bool collapsed) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: collapsed
          ? Center(
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Gs',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'VS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF93C5FD),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Gs',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -1,
                        ),
                      ),
                      TextSpan(
                        text: 'VS',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF93C5FD),
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Sistema Web para Gestão de\nViagens à Serviço',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.65),
                    height: 1.4,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSupportBox() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.headset_mic_rounded,
                color: Colors.white.withOpacity(0.9),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Suporte',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Precisa de ajuda?\nEntre em contato com\no suporte do sistema.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.65),
              fontSize: 11,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Abrir chamado',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapseButton(bool collapsed) {
    return InkWell(
      onTap: () => setState(() => _isCollapsed = !_isCollapsed),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          mainAxisAlignment: collapsed
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Icon(
              collapsed
                  ? Icons.chevron_right_rounded
                  : Icons.chevron_left_rounded,
              color: Colors.white.withOpacity(0.7),
              size: 20,
            ),
            if (!collapsed) ...[
              const SizedBox(width: 10),
              Text(
                'Recolher menu',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String route;
  const _NavItem(this.icon, this.label, this.route);
}
