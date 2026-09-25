import 'package:catem_app/core/constants/app_constants.dart';
import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/age_validator.dart';
import 'package:catem_app/core/utils/result.dart';

/// RNF-13: Catem es 18+. Bloquea el registro con un mensaje claro, no con una excepcion.
class ValidateMinimumAgeUseCase {
  const ValidateMinimumAgeUseCase({DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final DateTime Function() _now;

  Result<void> call({required DateTime birthDate}) {
    if (!AgeValidator.isAtLeast(
      AppConstants.minimumAge,
      birthDate,
      asOf: _now(),
    )) {
      return const Failed(
        ValidationFailure(
          'Debes tener al menos ${AppConstants.minimumAge} anos para usar Catem',
        ),
      );
    }
    return const Success(null);
  }
}
