import 'package:catem_app/core/config/env.dart';
import 'package:catem_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appName)),
      body: Center(child: Text('Hola Camilo - Entorno: ${Env.current.name}')),
    );
  }
}
