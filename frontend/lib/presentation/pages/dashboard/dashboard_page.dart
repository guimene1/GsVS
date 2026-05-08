import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';
import '../../templates/dashboard_template.dart';

/// Página do Dashboard
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = UserModel.stub;

    return DashboardTemplate(user: _user);
  }
}