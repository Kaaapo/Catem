import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/router/app_router.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/domain/entities/auth_event.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:catem_app/features/profile/domain/entities/profile_entity.dart';
import 'package:catem_app/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mocks.dart';

void main() {
  late MockAuthRepository auth;
  late MockProfileRepository profiles;
  late AuthRedirect redirect;

  const unverified = UserEntity(id: 'u1', email: 'a@b.co');
  const verified = UserEntity(id: 'u1', email: 'a@b.co', isEmailConfirmed: true);
  final completeProfile = ProfileEntity(
    id: 'u1',
    nickPublico: 'ana',
    fechaNacimiento: DateTime(2000),
    consentAcceptedAt: DateTime(2026),
    termsVersion: '1.0',
  );

  setUp(() {
    auth = MockAuthRepository();
    profiles = MockProfileRepository();
    redirect = AuthRedirect(auth, GetProfileUseCase(profiles));
  });

  void profileIs(ProfileEntity? profile) => when(
    () => profiles.getProfile('u1', forceRefresh: any(named: 'forceRefresh')),
  ).thenAnswer((_) async => Success(profile));

  test('sin sesion manda al login salvo que ya este en /auth', () async {
    when(() => auth.currentUser).thenReturn(null);

    expect(await redirect(AppRoutes.home), AppRoutes.login);
    expect(await redirect(AppRoutes.register), isNull);
  });

  test('con sesion sin verificar manda a /auth/verify', () async {
    when(() => auth.currentUser).thenReturn(unverified);

    expect(await redirect(AppRoutes.home), AppRoutes.verify);
    expect(await redirect(AppRoutes.verify), isNull);
  });

  test('verificado sin onboarding completo manda a /onboarding', () async {
    when(() => auth.currentUser).thenReturn(verified);
    profileIs(const ProfileEntity(id: 'u1'));

    expect(await redirect(AppRoutes.home), AppRoutes.onboarding);
    expect(await redirect(AppRoutes.onboarding), isNull);
  });

  test('con todo completo saca al usuario de auth/onboarding hacia home', () async {
    when(() => auth.currentUser).thenReturn(verified);
    profileIs(completeProfile);

    expect(await redirect(AppRoutes.login), AppRoutes.home);
    expect(await redirect(AppRoutes.onboarding), AppRoutes.home);
    expect(await redirect(AppRoutes.verifyEmailCallback), AppRoutes.home);
    expect(await redirect(AppRoutes.home), isNull);
  });

  test('si no se puede leer el perfil (sin red) no bloquea al usuario', () async {
    when(() => auth.currentUser).thenReturn(verified);
    when(
      () => profiles.getProfile('u1', forceRefresh: any(named: 'forceRefresh')),
    ).thenAnswer((_) async => const Failed(NetworkFailure()));

    expect(await redirect(AppRoutes.home), isNull);
  });

  test('el evento passwordRecovery fuerza la pantalla de nueva contrasena', () async {
    when(() => auth.currentUser).thenReturn(verified);
    profileIs(completeProfile);

    redirect.onAuthEvent(AuthEvent.passwordRecovery);

    expect(await redirect(AppRoutes.home), AppRoutes.resetPassword);
    expect(await redirect(AppRoutes.resetPasswordCallback), isNull);

    redirect.passwordUpdated();

    expect(await redirect(AppRoutes.resetPassword), AppRoutes.home);
  });
}
