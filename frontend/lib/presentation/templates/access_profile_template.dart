import 'package:flutter/material.dart';
import '../pages/access_profile/access_profile_page.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/user_model.dart';
import '../organisms/app_sidebar.dart';
import '../organisms/app_top_bar.dart';
import '../../router/app_router.dart';

class AccessProfileTemplate extends StatelessWidget {
  final UserModel user;
  final AccessProfileController controller;

  const AccessProfileTemplate({
    super.key,
    required this.user,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;
        return isMobile ? _buildMobile(context) : _buildDesktop(context);
      },
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      children: [
        AppSideBar(user: user, currentRoute: AppRoutes.perfis),
        Expanded(
          child: Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppTopBar(user: user),
            body: _buildBody(),
          ),
        ),
      ],
    );
  }



  Widget _buildMobile(BuildContext context){
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.background,
      appBar: AppTopBar(
        user: user, onMenuTap: () => scaffoldKey.currentState?.openDrawer()),
      drawer: Drawer(
        width: 250,
        child: AppSidebar(
          user: user,
          currentRoute: AppRoutes.perfis,
        ),
      ),
      body: _buildBody(),

    );
  }

  Widget _buildBody() {
return const Center(child: Text('Perfisss'),),  }
}
