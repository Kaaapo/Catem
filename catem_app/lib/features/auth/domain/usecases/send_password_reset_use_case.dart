import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/domain/repositories/auth_repository.dart';

class SendPasswordResetUseCase {
  const SendPasswordResetUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> call({required String email}) =>
      _repository.sendPasswordReset(email: email.trim());
}
