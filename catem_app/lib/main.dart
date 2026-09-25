import 'package:catem_app/app.dart';
import 'package:catem_app/core/config/env.dart';
import 'package:catem_app/features/notifications/push_bootstrap.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Env.validate();
  await Supabase.initialize(
    url: Env.supabaseUrl,
    publishableKey: Env.supabasePublishableKey,
  );
  await initializePushNotifications();
  runApp(const ProviderScope(child: CatemApp()));
}
