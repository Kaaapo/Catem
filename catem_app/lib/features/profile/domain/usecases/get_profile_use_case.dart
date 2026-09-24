import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/profile/domain/entities/profile_entity.dart';
import 'package:catem_app/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase {
  const GetProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Result<ProfileEntity?>> call(
    String userId, {
    bool forceRefresh = false,
  }) {
    return _repository.getProfile(userId, forceRefresh: forceRefresh);
  }
}
