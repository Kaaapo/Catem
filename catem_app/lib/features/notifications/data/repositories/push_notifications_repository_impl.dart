import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/notifications/data/datasources/device_token_remote_data_source.dart';
import 'package:catem_app/features/notifications/data/datasources/fcm_remote_data_source.dart';
import 'package:catem_app/features/notifications/domain/repositories/push_notifications_repository.dart';

class PushNotificationsRepositoryImpl implements PushNotificationsRepository {
  const PushNotificationsRepositoryImpl(
    this._fcm,
    this._tokens,
    this._platform,
  );

  final FcmRemoteDataSource _fcm;
  final DeviceTokenRemoteDataSource _tokens;
  final String _platform;

  @override
  Future<Result<bool>> requestPermission() async {
    try {
      return Success(await _fcm.requestPermission());
    } on Exception catch (e) {
      return Failed(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> registerCurrentDevice({required String userId}) async {
    try {
      final token = await _fcm.getToken();
      if (token == null) {
        return const Failed(ServerFailure('FCM no entrego token'));
      }
      await _tokens.upsertToken(
        userId: userId,
        token: token,
        platform: _platform,
      );
      return const Success(null);
    } on Exception catch (e) {
      return Failed(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<String> get onTokenRefresh => _fcm.onTokenRefresh;
}
