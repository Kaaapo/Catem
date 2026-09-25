import 'package:flutter/material.dart';

/// Pantalla provisional: la logica (providers, router) ya existe; la UI real
/// se construye cuando esten los mockups de Figma (CATEM-74 / CATEM-75).
class PendingMockupScreen extends StatelessWidget {
  const PendingMockupScreen({
    required this.title,
    required this.ticket,
    super.key,
    this.actions = const [],
  });

  final String title;
  final String ticket;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Text(
                'Pantalla pendiente de mockups (CATEM-75).\nLogica lista en $ticket.',
                textAlign: TextAlign.center,
              ),
              ...actions,
            ],
          ),
        ),
      ),
    );
  }
}
