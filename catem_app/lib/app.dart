import 'package:catem_app/core/constants/app_constants.dart';
import 'package:catem_app/core/router/app_router.dart';
import 'package:catem_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatemApp extends ConsumerWidget {
  const CatemApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: AppConstants.appName,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
