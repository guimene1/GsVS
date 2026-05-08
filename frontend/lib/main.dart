import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'router/app_router.dart';

void main() {
  runApp(const GsVSApp());
}

class GsVSApp extends StatelessWidget {
  const GsVSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GsVS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: createRouter(),
    );
  }
}
