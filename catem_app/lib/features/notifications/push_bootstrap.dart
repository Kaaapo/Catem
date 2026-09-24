import 'package:catem_app/core/config/env.dart';
import 'package:catem_app/features/notifications/data/datasources/fcm_remote_data_source.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Inicializa Firebase leyendo google-services.json / GoogleService-Info.plist.
/// Sin esos archivos (build sin PUSH_ENABLED) no se toca Firebase y la app corre igual.
Future<void> initializePushNotifications() async {
  if (!Env.pushEnabled) return;
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}
