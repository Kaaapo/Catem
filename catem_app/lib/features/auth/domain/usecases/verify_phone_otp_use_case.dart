import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:catem_app/features/auth/domain/repositories/auth_repository.dart';

class VerifyPhoneOtpUseCase {
  const VerifyPhoneOtpUseCase(this._repository);

  static final _sixDigits = RegExp(r'^\d{6}$');

  final AuthRepository _repository;

  Future<Result<UserEntity>> call({required String phone, required String code}) {
    if (!_sixDigits.hasMatch(code)) {
      return Future.value(
        const Failed(ValidationFailure('El codigo debe tener 6 digitos')),
      );
    }
    return _repository.verifyPhoneOtp(phone: phone, code: code);
  }
}
