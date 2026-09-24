import 'package:firebase_messaging/firebase_messaging.dart';

// Firebase exige que el handler de background sea una funcion top-level.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Las notificaciones con `notification` las muestra el sistema; aqui solo
  // llegan mensajes de datos. La logica por tipo se agrega en Ciclo 3 (mood).
}

abstract interface class FcmRemoteDataSource {
  Future<bool> requestPermission();

  Future<String?> getToken();

  Stream<String> get onTokenRefresh;
}

class FirebaseFcmRemoteDataSource implements FcmRemoteDataSource {
  const FirebaseFcmRemoteDataSource(this._messaging);

  final FirebaseMessaging _messaging;

  @override
  Future<bool> requestPermission() async {
    final settings = await _messaging.requestPermission();
    const granted = {
      AuthorizationStatus.authorized,
      AuthorizationStatus.provisional,
    };
    return granted.contains(settings.authorizationStatus);
  }

  @override
  Future<String?> getToken() => _messaging.getToken();

  @override
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;
}
