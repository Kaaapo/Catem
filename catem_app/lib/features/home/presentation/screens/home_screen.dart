import 'package:catem_app/core/config/env.dart';
import 'package:catem_app/core/constants/app_constants.dart';
import 'package:catem_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesion',
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
          ),
        ],
      ),
      body: Center(child: Text('Entorno: ${Env.current.name}')),
    );
  }
}
