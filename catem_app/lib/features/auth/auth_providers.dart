import 'package:catem_app/core/config/env.dart';
import 'package:catem_app/core/local_database/local_database_provider.dart';
import 'package:catem_app/core/network/supabase_provider.dart';
import 'package:catem_app/features/auth/data/datasources/apple_auth_data_source.dart';
import 'package:catem_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:catem_app/features/auth/data/datasources/google_auth_data_source.dart';
import 'package:catem_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:catem_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:catem_app/features/auth/domain/usecases/refresh_current_user_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/request_phone_otp_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/resend_email_confirmation_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/send_password_reset_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/sign_in_with_apple_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/sign_in_with_google_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/update_password_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/validate_minimum_age_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/verify_phone_otp_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) =>
    SupabaseAuthRemoteDataSource(ref.watch(supabaseClientProvider));

@riverpod
GoogleAuthDataSource googleAuthDataSource(Ref ref) => GoogleSignInAuthDataSource(
  Env.googleWebClientId,
  Env.googleIosClientId.isEmpty ? null : Env.googleIosClientId,
);

@riverpod
AppleAuthDataSource appleAuthDataSource(Ref ref) =>
    const SignInWithAppleAuthDataSource();

@riverpod
AuthRepository authRepository(Ref ref) => AuthRepositoryImpl(
  ref.watch(authRemoteDataSourceProvider),
  ref.watch(googleAuthDataSourceProvider),
  ref.watch(appleAuthDataSourceProvider),
  ref.watch(appDatabaseProvider).clearAll,
);

@riverpod
SignUpUseCase signUpUseCase(Ref ref) =>
    SignUpUseCase(ref.watch(authRepositoryProvider));

@riverpod
SignInUseCase signInUseCase(Ref ref) =>
    SignInUseCase(ref.watch(authRepositoryProvider));

@riverpod
SignOutUseCase signOutUseCase(Ref ref) =>
    SignOutUseCase(ref.watch(authRepositoryProvider));

@riverpod
SignInWithGoogleUseCase signInWithGoogleUseCase(Ref ref) =>
    SignInWithGoogleUseCase(ref.watch(authRepositoryProvider));

@riverpod
SignInWithAppleUseCase signInWithAppleUseCase(Ref ref) =>
    SignInWithAppleUseCase(ref.watch(authRepositoryProvider));

@riverpod
RequestPhoneOtpUseCase requestPhoneOtpUseCase(Ref ref) =>
    RequestPhoneOtpUseCase(ref.watch(authRepositoryProvider));

@riverpod
VerifyPhoneOtpUseCase verifyPhoneOtpUseCase(Ref ref) =>
    VerifyPhoneOtpUseCase(ref.watch(authRepositoryProvider));

@riverpod
SendPasswordResetUseCase sendPasswordResetUseCase(Ref ref) =>
    SendPasswordResetUseCase(ref.watch(authRepositoryProvider));

@riverpod
UpdatePasswordUseCase updatePasswordUseCase(Ref ref) =>
    UpdatePasswordUseCase(ref.watch(authRepositoryProvider));

@riverpod
ResendEmailConfirmationUseCase resendEmailConfirmationUseCase(Ref ref) =>
    ResendEmailConfirmationUseCase(ref.watch(authRepositoryProvider));

@riverpod
RefreshCurrentUserUseCase refreshCurrentUserUseCase(Ref ref) =>
    RefreshCurrentUserUseCase(ref.watch(authRepositoryProvider));

@riverpod
ValidateMinimumAgeUseCase validateMinimumAgeUseCase(Ref ref) =>
    const ValidateMinimumAgeUseCase();
