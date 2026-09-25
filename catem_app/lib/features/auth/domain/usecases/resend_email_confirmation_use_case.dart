import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/domain/repositories/auth_repository.dart';

class ResendEmailConfirmationUseCase {
  const ResendEmailConfirmationUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> call({required String email}) =>
      _repository.resendEmailConfirmation(email: email.trim());
}
