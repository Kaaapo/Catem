import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:catem_app/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  const SignUpUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<UserEntity>> call({
    required String email,
    required String password,
  }) {
    return _repository.signUpWithEmail(email: email, password: password);
  }
}
