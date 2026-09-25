import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:catem_app/features/auth/domain/repositories/auth_repository.dart';

class UpdatePasswordUseCase {
  const UpdatePasswordUseCase(this._repository);

  static const minLength = 8;

  final AuthRepository _repository;

  Future<Result<UserEntity>> call({required String newPassword}) {
    if (newPassword.length < minLength) {
      return Future.value(
        const Failed(
          ValidationFailure('La contrasena debe tener al menos $minLength caracteres'),
        ),
      );
    }
    return _repository.updatePassword(newPassword: newPassword);
  }
}
