import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/domain/repositories/auth_repository.dart';

class RequestPhoneOtpUseCase {
  const RequestPhoneOtpUseCase(this._repository);

  static final _e164 = RegExp(r'^\+[1-9]\d{6,14}$');

  final AuthRepository _repository;

  Future<Result<void>> call({required String phone}) {
    if (!_e164.hasMatch(phone)) {
      return Future.value(
        const Failed(
          ValidationFailure('El telefono debe ir en formato internacional, ej. +573001234567'),
        ),
      );
    }
    return _repository.requestPhoneOtp(phone: phone);
  }
}
