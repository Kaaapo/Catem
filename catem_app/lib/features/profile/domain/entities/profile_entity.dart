import 'package:catem_app/core/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  const ProfileEntity({
    required this.id,
    this.nickPublico,
    this.nombreReal,
    this.fechaNacimiento,
    this.ciudad,
    this.consentAcceptedAt,
    this.termsVersion,
  });

  final String id;
  final String? nickPublico;
  final String? nombreReal;
  final DateTime? fechaNacimiento;
  final String? ciudad;
  final DateTime? consentAcceptedAt;
  final String? termsVersion;

  bool get hasAcceptedCurrentTerms =>
      consentAcceptedAt != null && termsVersion == AppConstants.termsVersion;

  bool get isOnboardingComplete =>
      nickPublico != null && fechaNacimiento != null && hasAcceptedCurrentTerms;

  @override
  List<Object?> get props => [
    id,
    nickPublico,
    nombreReal,
    fechaNacimiento,
    ciudad,
    consentAcceptedAt,
    termsVersion,
  ];
}
