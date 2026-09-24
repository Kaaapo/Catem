import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/notifications/domain/repositories/push_notifications_repository.dart';

class RegisterDeviceForPushUseCase {
  const RegisterDeviceForPushUseCase(this._repository);

  final PushNotificationsRepository _repository;

  Future<Result<void>> call({required String userId}) async {
    final permission = await _repository.requestPermission();
    return switch (permission) {
      Failed(:final failure) => Failed(failure),
      Success(value: false) => const Failed(
        PermissionFailure('El usuario no autorizo las notificaciones'),
      ),
      Success(value: true) => await _repository.registerCurrentDevice(
        userId: userId,
      ),
    };
  }
}
