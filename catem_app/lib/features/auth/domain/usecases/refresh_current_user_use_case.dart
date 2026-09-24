import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:catem_app/features/auth/domain/repositories/auth_repository.dart';

/// Vuelve a pedir el usuario al servidor (ej. tras confirmar el email desde el correo).
class RefreshCurrentUserUseCase {
  const RefreshCurrentUserUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<UserEntity?>> call() => _repository.refreshCurrentUser();
}
