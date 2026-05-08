import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/user_model.dart';
import '../../router/app_router.dart';
import '../organisms/app_sidebar.dart';
import '../organisms/app_top_bar.dart';

class DashboardTemplate extends StatefulWidget {
  final UserModel user;
  final bool isLoading;

  const DashboardTemplate({
    super.key,
    required this.user,
    this.isLoading = false,
  });

  @override
  State<DashboardTemplate> createState() => _DashboardTemplateState();
}

class _DashboardTemplateState extends State<DashboardTemplate> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;
        return isMobile ? _buildMobileLayout() : _buildDesktopLayout();
      },
    );
  }

  // --- Layouts Principais ---

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        AppSidebar(
          user: widget.user,
          currentRoute: AppRoutes.dashboard,
        ),
        Expanded(
          child: Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppTopBar(user: widget.user),
            body: _buildContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      appBar: AppTopBar(
        user: widget.user,
        onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: Drawer(
        width: 250,
        child: AppSidebar(
          user: widget.user,
          currentRoute: AppRoutes.dashboard,
        ),
      ),
      body: _buildContent(),
    );
  }

  // --- Conteúdo Dinâmico ---

  Widget _buildContent() {
    if (widget.isLoading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPageHeader(),
                    const SizedBox(height: 32),
                    
                    // Área Central: Aqui entrará a lógica das abas ou mensagem de boas-vindas
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Selecione um módulo no menu lateral para começar.',
                          style: TextStyle(color: Color(0xFF6B7280), fontSize: 16),
                        ),
                      ),
                    ),
                    
                    const Spacer(), // Empurra o footer para o final
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Olá, ${widget.user.name.split(' ').first}!',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F1F4D),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Bem-vindo(a) ao Sistema de Gestão de Viagens e Solicitações (GsVS).',
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return const Padding(
      padding: EdgeInsets.only(top: 40, bottom: 8),
      child: Center(
        child: Text(
          '© 2024 GsVS - Prefeitura Municipal de Prudentópolis. Todos os direitos reservados.',
          style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}