// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider = AuthRemoteDataSourceProvider._();

final class AuthRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          AuthRemoteDataSource,
          AuthRemoteDataSource,
          AuthRemoteDataSource
        >
    with $Provider<AuthRemoteDataSource> {
  AuthRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<AuthRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthRemoteDataSource create(Ref ref) {
    return authRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRemoteDataSource>(value),
    );
  }
}

String _$authRemoteDataSourceHash() =>
    r'a25d4a1a8ae9cdc2d921881a7dd09390ffe32096';

@ProviderFor(googleAuthDataSource)
final googleAuthDataSourceProvider = GoogleAuthDataSourceProvider._();

final class GoogleAuthDataSourceProvider
    extends
        $FunctionalProvider<
          GoogleAuthDataSource,
          GoogleAuthDataSource,
          GoogleAuthDataSource
        >
    with $Provider<GoogleAuthDataSource> {
  GoogleAuthDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleAuthDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleAuthDataSourceHash();

  @$internal
  @override
  $ProviderElement<GoogleAuthDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoogleAuthDataSource create(Ref ref) {
    return googleAuthDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleAuthDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleAuthDataSource>(value),
    );
  }
}

String _$googleAuthDataSourceHash() =>
    r'493a04503497cb6dae3c1c77269d691ebf42d466';

@ProviderFor(appleAuthDataSource)
final appleAuthDataSourceProvider = AppleAuthDataSourceProvider._();

final class AppleAuthDataSourceProvider
    extends
        $FunctionalProvider<
          AppleAuthDataSource,
          AppleAuthDataSource,
          AppleAuthDataSource
        >
    with $Provider<AppleAuthDataSource> {
  AppleAuthDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appleAuthDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appleAuthDataSourceHash();

  @$internal
  @override
  $ProviderElement<AppleAuthDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppleAuthDataSource create(Ref ref) {
    return appleAuthDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppleAuthDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppleAuthDataSource>(value),
    );
  }
}

String _$appleAuthDataSourceHash() =>
    r'3d8e70bb18e2882e1a06a7391c080881292d8c99';

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'b5d004173f419f73a6bb83299f41ee47e347c0ee';

@ProviderFor(signUpUseCase)
final signUpUseCaseProvider = SignUpUseCaseProvider._();

final class SignUpUseCaseProvider
    extends $FunctionalProvider<SignUpUseCase, SignUpUseCase, SignUpUseCase>
    with $Provider<SignUpUseCase> {
  SignUpUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signUpUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signUpUseCaseHash();

  @$internal
  @override
  $ProviderElement<SignUpUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignUpUseCase create(Ref ref) {
    return signUpUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignUpUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignUpUseCase>(value),
    );
  }
}

String _$signUpUseCaseHash() => r'a17a800a8f36957d8f48f69f71ba5bd9f882df68';

@ProviderFor(signInUseCase)
final signInUseCaseProvider = SignInUseCaseProvider._();

final class SignInUseCaseProvider
    extends $FunctionalProvider<SignInUseCase, SignInUseCase, SignInUseCase>
    with $Provider<SignInUseCase> {
  SignInUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signInUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signInUseCaseHash();

  @$internal
  @override
  $ProviderElement<SignInUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignInUseCase create(Ref ref) {
    return signInUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignInUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignInUseCase>(value),
    );
  }
}

String _$signInUseCaseHash() => r'3be5fb94ae08302bbccc4de0394917075359007c';

@ProviderFor(signOutUseCase)
final signOutUseCaseProvider = SignOutUseCaseProvider._();

final class SignOutUseCaseProvider
    extends $FunctionalProvider<SignOutUseCase, SignOutUseCase, SignOutUseCase>
    with $Provider<SignOutUseCase> {
  SignOutUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signOutUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signOutUseCaseHash();

  @$internal
  @override
  $ProviderElement<SignOutUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignOutUseCase create(Ref ref) {
    return signOutUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignOutUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignOutUseCase>(value),
    );
  }
}

String _$signOutUseCaseHash() => r'43b88dc732fc2ec257d73871891f04dcae657f24';

@ProviderFor(signInWithGoogleUseCase)
final signInWithGoogleUseCaseProvider = SignInWithGoogleUseCaseProvider._();

final class SignInWithGoogleUseCaseProvider
    extends
        $FunctionalProvider<
          SignInWithGoogleUseCase,
          SignInWithGoogleUseCase,
          SignInWithGoogleUseCase
        >
    with $Provider<SignInWithGoogleUseCase> {
  SignInWithGoogleUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signInWithGoogleUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signInWithGoogleUseCaseHash();

  @$internal
  @override
  $ProviderElement<SignInWithGoogleUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SignInWithGoogleUseCase create(Ref ref) {
    return signInWithGoogleUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignInWithGoogleUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignInWithGoogleUseCase>(value),
    );
  }
}

String _$signInWithGoogleUseCaseHash() =>
    r'e677af0f5be96979b5ffb65257967d4357e7eb4d';

@ProviderFor(signInWithAppleUseCase)
final signInWithAppleUseCaseProvider = SignInWithAppleUseCaseProvider._();

final class SignInWithAppleUseCaseProvider
    extends
        $FunctionalProvider<
          SignInWithAppleUseCase,
          SignInWithAppleUseCase,
          SignInWithAppleUseCase
        >
    with $Provider<SignInWithAppleUseCase> {
  SignInWithAppleUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signInWithAppleUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signInWithAppleUseCaseHash();

  @$internal
  @override
  $ProviderElement<SignInWithAppleUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SignInWithAppleUseCase create(Ref ref) {
    return signInWithAppleUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignInWithAppleUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignInWithAppleUseCase>(value),
    );
  }
}

String _$signInWithAppleUseCaseHash() =>
    r'02473e2aeeccd4a8f5a50840048f6eb8f6675797';

@ProviderFor(requestPhoneOtpUseCase)
final requestPhoneOtpUseCaseProvider = RequestPhoneOtpUseCaseProvider._();

final class RequestPhoneOtpUseCaseProvider
    extends
        $FunctionalProvider<
          RequestPhoneOtpUseCase,
          RequestPhoneOtpUseCase,
          RequestPhoneOtpUseCase
        >
    with $Provider<RequestPhoneOtpUseCase> {
  RequestPhoneOtpUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requestPhoneOtpUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requestPhoneOtpUseCaseHash();

  @$internal
  @override
  $ProviderElement<RequestPhoneOtpUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RequestPhoneOtpUseCase create(Ref ref) {
    return requestPhoneOtpUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RequestPhoneOtpUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RequestPhoneOtpUseCase>(value),
    );
  }
}

String _$requestPhoneOtpUseCaseHash() =>
    r'2a9deb6f25e18b13d01ab879ccc9f7463be57617';

@ProviderFor(verifyPhoneOtpUseCase)
final verifyPhoneOtpUseCaseProvider = VerifyPhoneOtpUseCaseProvider._();

final class VerifyPhoneOtpUseCaseProvider
    extends
        $FunctionalProvider<
          VerifyPhoneOtpUseCase,
          VerifyPhoneOtpUseCase,
          VerifyPhoneOtpUseCase
        >
    with $Provider<VerifyPhoneOtpUseCase> {
  VerifyPhoneOtpUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyPhoneOtpUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyPhoneOtpUseCaseHash();

  @$internal
  @override
  $ProviderElement<VerifyPhoneOtpUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VerifyPhoneOtpUseCase create(Ref ref) {
    return verifyPhoneOtpUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VerifyPhoneOtpUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VerifyPhoneOtpUseCase>(value),
    );
  }
}

String _$verifyPhoneOtpUseCaseHash() =>
    r'f74a2e9e30c9532d7d9a1a8d23e8bc9437831291';

@ProviderFor(sendPasswordResetUseCase)
final sendPasswordResetUseCaseProvider = SendPasswordResetUseCaseProvider._();

final class SendPasswordResetUseCaseProvider
    extends
        $FunctionalProvider<
          SendPasswordResetUseCase,
          SendPasswordResetUseCase,
          SendPasswordResetUseCase
        >
    with $Provider<SendPasswordResetUseCase> {
  SendPasswordResetUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sendPasswordResetUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sendPasswordResetUseCaseHash();

  @$internal
  @override
  $ProviderElement<SendPasswordResetUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SendPasswordResetUseCase create(Ref ref) {
    return sendPasswordResetUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SendPasswordResetUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SendPasswordResetUseCase>(value),
    );
  }
}

String _$sendPasswordResetUseCaseHash() =>
    r'e231c65b713e94dd19c971da5147d81595224a39';

@ProviderFor(updatePasswordUseCase)
final updatePasswordUseCaseProvider = UpdatePasswordUseCaseProvider._();

final class UpdatePasswordUseCaseProvider
    extends
        $FunctionalProvider<
          UpdatePasswordUseCase,
          UpdatePasswordUseCase,
          UpdatePasswordUseCase
        >
    with $Provider<UpdatePasswordUseCase> {
  UpdatePasswordUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updatePasswordUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updatePasswordUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdatePasswordUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdatePasswordUseCase create(Ref ref) {
    return updatePasswordUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdatePasswordUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdatePasswordUseCase>(value),
    );
  }
}

String _$updatePasswordUseCaseHash() =>
    r'f686146f4d5d26bf19d76f7eb8ce974a6fadec44';

@ProviderFor(resendEmailConfirmationUseCase)
final resendEmailConfirmationUseCaseProvider =
    ResendEmailConfirmationUseCaseProvider._();

final class ResendEmailConfirmationUseCaseProvider
    extends
        $FunctionalProvider<
          ResendEmailConfirmationUseCase,
          ResendEmailConfirmationUseCase,
          ResendEmailConfirmationUseCase
        >
    with $Provider<ResendEmailConfirmationUseCase> {
  ResendEmailConfirmationUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resendEmailConfirmationUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resendEmailConfirmationUseCaseHash();

  @$internal
  @override
  $ProviderElement<ResendEmailConfirmationUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ResendEmailConfirmationUseCase create(Ref ref) {
    return resendEmailConfirmationUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResendEmailConfirmationUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResendEmailConfirmationUseCase>(
        value,
      ),
    );
  }
}

String _$resendEmailConfirmationUseCaseHash() =>
    r'054b5cefa602900097a1c966700e9d1426638c1b';

@ProviderFor(refreshCurrentUserUseCase)
final refreshCurrentUserUseCaseProvider = RefreshCurrentUserUseCaseProvider._();

final class RefreshCurrentUserUseCaseProvider
    extends
        $FunctionalProvider<
          RefreshCurrentUserUseCase,
          RefreshCurrentUserUseCase,
          RefreshCurrentUserUseCase
        >
    with $Provider<RefreshCurrentUserUseCase> {
  RefreshCurrentUserUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'refreshCurrentUserUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$refreshCurrentUserUseCaseHash();

  @$internal
  @override
  $ProviderElement<RefreshCurrentUserUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RefreshCurrentUserUseCase create(Ref ref) {
    return refreshCurrentUserUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RefreshCurrentUserUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RefreshCurrentUserUseCase>(value),
    );
  }
}

String _$refreshCurrentUserUseCaseHash() =>
    r'345308f879555bdf204707243826b9d2feb1a6b4';

@ProviderFor(validateMinimumAgeUseCase)
final validateMinimumAgeUseCaseProvider = ValidateMinimumAgeUseCaseProvider._();

final class ValidateMinimumAgeUseCaseProvider
    extends
        $FunctionalProvider<
          ValidateMinimumAgeUseCase,
          ValidateMinimumAgeUseCase,
          ValidateMinimumAgeUseCase
        >
    with $Provider<ValidateMinimumAgeUseCase> {
  ValidateMinimumAgeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'validateMinimumAgeUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$validateMinimumAgeUseCaseHash();

  @$internal
  @override
  $ProviderElement<ValidateMinimumAgeUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ValidateMinimumAgeUseCase create(Ref ref) {
    return validateMinimumAgeUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ValidateMinimumAgeUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ValidateMinimumAgeUseCase>(value),
    );
  }
}

String _$validateMinimumAgeUseCaseHash() =>
    r'5bca22945688f256196ffa6ec8c0f677a98fde59';
