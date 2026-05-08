import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/user_model.dart';
import '../../router/app_router.dart';
import '../organisms/app_sidebar.dart';
import '../organisms/app_top_bar.dart';

class DashboardTemplate extends StatelessWidget {
  final UserModel user;

  const DashboardTemplate({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;
        return isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context);
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        AppSidebar(
          user: user,
          currentRoute: AppRoutes.dashboard,
        ),
        Expanded(
          child: Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppTopBar(user: user),
            body: _buildContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.background,
      appBar: AppTopBar(
        user: user,
        onMenuTap: () => scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: Drawer(
        width: 250,
        child: AppSidebar(
          user: user,
          currentRoute: AppRoutes.dashboard,
        ),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.dashboard_rounded,
              size: 80,
              color: AppColors.primary,
            ),
            const SizedBox(height: 24),
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Selecione um módulo no menu lateral para começar.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}