import 'package:catem_app/core/utils/result.dart';

abstract interface class PushNotificationsRepository {
  Future<Result<bool>> requestPermission();

  Future<Result<void>> registerCurrentDevice({required String userId});

  Stream<String> get onTokenRefresh;
}
