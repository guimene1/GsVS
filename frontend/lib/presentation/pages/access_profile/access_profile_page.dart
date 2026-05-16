import 'package:flutter/material.dart';
import 'package:frontend/presentation/templates/access_profile_template.dart';
import 'access_profile_controller.dart';

class PerfisAcessoPage extends StatefulWidget {
  const PerfisAcessoPage({super.key});

  @override
  State<PerfisAcessoPage> createState() => _PerfisAcessoPageState();
}

class _PerfisAcessoPageState extends State<PerfisAcessoPage> {
  final _controller = AccessProfileController();

  @override
  void initState() {
    super.initState();
    _controller.loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) => AccessProfileTemplate(user: user, controller: controller){
        return Scaffold(
          appBar: AppBar(title: const Text('Perfis de Acesso')),
          body: _controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _controller.errorMessage != null
                  ? Center(child: Text(_controller.errorMessage!))
                  : ListView.builder(
                      itemCount: _controller.profiles.length,
                      itemBuilder: (context, index) {
                        final profile = _controller.profiles[index];
                        return ListTile(
                          title: Text(profile.name),
                          subtitle: Text(
                            profile.modules.map((m) => m.label).join(', '),
                          ),
                          trailing: Switch(
                            value: profile.isActive,
                            onChanged: (_) =>
                                _controller.toggleActive(profile.id),
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }
}