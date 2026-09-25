import 'package:catem_app/core/router/stream_listenable.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/core/widgets/pending_mockup_screen.dart';
import 'package:catem_app/features/auth/auth_providers.dart';
import 'package:catem_app/features/auth/domain/entities/auth_event.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:catem_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:catem_app/features/home/presentation/screens/home_screen.dart';
import 'package:catem_app/features/profile/domain/entities/profile_entity.dart';
import 'package:catem_app/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:catem_app/features/profile/profile_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

abstract final class AppRoutes {
  static const String home = '/';
  static const String authPrefix = '/auth';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String phone = '/auth/phone';
  static const String verify = '/auth/verify';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String onboarding = '/onboarding';

  // Deep links catem://auth-callback/<path>: segun la plataforma llega con o sin host.
  static const String resetPasswordCallback = '/auth-callback/reset-password';
  static const String verifyEmailCallback = '/auth-callback/verify-email';
  static const String verifyEmail = '/verify-email';
}

/// Decide a donde va el usuario segun sesion, verificacion y onboarding (CATEM-22/23/24).
class AuthRedirect {
  AuthRedirect(this._auth, this._getProfile);

  final AuthRepository _auth;
  final GetProfileUseCase _getProfile;

  @visibleForTesting
  bool passwordRecoveryPending = false;

  void onAuthEvent(AuthEvent event) {
    if (event == AuthEvent.passwordRecovery) passwordRecoveryPending = true;
    if (event == AuthEvent.signedOut) passwordRecoveryPending = false;
  }

  Future<String?> call(String location) async {
    final user = _auth.currentUser;
    final inAuth = location.startsWith(AppRoutes.authPrefix);

    if (user == null) return inAuth ? null : AppRoutes.login;

    if (passwordRecoveryPending) {
      if (_isResetPassword(location)) return null;
      return AppRoutes.resetPassword;
    }

    if (!user.isVerified) {
      return location == AppRoutes.verify ? null : AppRoutes.verify;
    }

    if (!await _isOnboardingComplete(user)) {
      return location == AppRoutes.onboarding ? null : AppRoutes.onboarding;
    }

    final leavingFlow =
        inAuth || location == AppRoutes.onboarding || _isCallback(location);
    return leavingFlow ? AppRoutes.home : null;
  }

  void passwordUpdated() => passwordRecoveryPending = false;

  Future<bool> _isOnboardingComplete(UserEntity user) async {
    final result = await _getProfile(user.id);
    return switch (result) {
      Success(:final value) => value?.isOnboardingComplete ?? false,
      // Sin cache ni red no bloqueamos al usuario; se reevalua al recuperar conexion.
      Failed<ProfileEntity?>() => true,
    };
  }

  bool _isResetPassword(String location) =>
      location == AppRoutes.resetPassword ||
      location == AppRoutes.resetPasswordCallback;

  bool _isCallback(String location) =>
      location == AppRoutes.verifyEmail ||
      location == AppRoutes.verifyEmailCallback ||
      _isResetPassword(location);
}

@riverpod
AuthRedirect authRedirect(Ref ref) => AuthRedirect(
  ref.watch(authRepositoryProvider),
  ref.watch(getProfileUseCaseProvider),
);

@riverpod
GoRouter appRouter(Ref ref) {
  final auth = ref.watch(authRepositoryProvider);
  final redirect = ref.watch(authRedirectProvider);

  final refresh = StreamListenable(auth.authStateChanges);
  final events = auth.authEvents.listen((event) {
    redirect.onAuthEvent(event);
    refresh.notify();
  });
  ref
    ..onDispose(refresh.dispose)
    ..onDispose(events.cancel);

  return GoRouter(
    initialLocation: AppRoutes.home,
    refreshListenable: refresh,
    redirect: (context, state) => redirect(state.matchedLocation),
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) =>
            const PendingMockupScreen(title: 'Login', ticket: 'CATEM-22'),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) =>
            const PendingMockupScreen(title: 'Registro', ticket: 'CATEM-21'),
      ),
      GoRoute(
        path: AppRoutes.phone,
        builder: (context, state) => const PendingMockupScreen(
          title: 'Registro por telefono',
          ticket: 'CATEM-21',
        ),
      ),
      GoRoute(
        path: AppRoutes.verify,
        builder: (context, state) => const PendingMockupScreen(
          title: 'Verifica tu cuenta',
          ticket: 'CATEM-24',
        ),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const PendingMockupScreen(
          title: 'Recuperar contrasena',
          ticket: 'CATEM-23',
        ),
      ),
      for (final path in [
        AppRoutes.resetPassword,
        AppRoutes.resetPasswordCallback,
      ])
        GoRoute(
          path: path,
          builder: (context, state) => const PendingMockupScreen(
            title: 'Nueva contrasena',
            ticket: 'CATEM-23',
          ),
        ),
      for (final path in [AppRoutes.verifyEmail, AppRoutes.verifyEmailCallback])
        GoRoute(path: path, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const PendingMockupScreen(
          title: 'Onboarding',
          ticket: 'CATEM-25 / CATEM-99',
        ),
      ),
    ],
  );
}
