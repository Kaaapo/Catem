import 'package:catem_app/core/constants/app_constants.dart';
import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/profile/domain/entities/profile_entity.dart';
import 'package:catem_app/features/profile/domain/repositories/profile_repository.dart';

/// RNF-01: el consentimiento debe ser explicito (checkbox marcado por el usuario)
/// y queda registrado con fecha y version del documento.
class AcceptConsentUseCase {
  const AcceptConsentUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Result<ProfileEntity>> call({
    required String userId,
    required bool checkboxAccepted,
  }) {
    if (!checkboxAccepted) {
      return Future.value(
        const Failed(
          ValidationFailure(
            'Debes aceptar los terminos y la politica de datos para continuar',
          ),
        ),
      );
    }
    return _repository.acceptConsent(
      userId: userId,
      termsVersion: AppConstants.termsVersion,
    );
  }
}
