// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(profileRemoteDataSource)
final profileRemoteDataSourceProvider = ProfileRemoteDataSourceProvider._();

final class ProfileRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          ProfileRemoteDataSource,
          ProfileRemoteDataSource,
          ProfileRemoteDataSource
        >
    with $Provider<ProfileRemoteDataSource> {
  ProfileRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<ProfileRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfileRemoteDataSource create(Ref ref) {
    return profileRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileRemoteDataSource>(value),
    );
  }
}

String _$profileRemoteDataSourceHash() =>
    r'232a4ca274208d8e08f1741298515a204169f698';

@ProviderFor(profileLocalDataSource)
final profileLocalDataSourceProvider = ProfileLocalDataSourceProvider._();

final class ProfileLocalDataSourceProvider
    extends
        $FunctionalProvider<
          ProfileLocalDataSource,
          ProfileLocalDataSource,
          ProfileLocalDataSource
        >
    with $Provider<ProfileLocalDataSource> {
  ProfileLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<ProfileLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfileLocalDataSource create(Ref ref) {
    return profileLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileLocalDataSource>(value),
    );
  }
}

String _$profileLocalDataSourceHash() =>
    r'3e903294f06fce6b6d49b863b16acb5f29c7d852';

@ProviderFor(profileRepository)
final profileRepositoryProvider = ProfileRepositoryProvider._();

final class ProfileRepositoryProvider
    extends
        $FunctionalProvider<
          ProfileRepository,
          ProfileRepository,
          ProfileRepository
        >
    with $Provider<ProfileRepository> {
  ProfileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProfileRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfileRepository create(Ref ref) {
    return profileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileRepository>(value),
    );
  }
}

String _$profileRepositoryHash() => r'ffbe76759c6e2cf24b0e4325732b8e719ca108f9';

@ProviderFor(getProfileUseCase)
final getProfileUseCaseProvider = GetProfileUseCaseProvider._();

final class GetProfileUseCaseProvider
    extends
        $FunctionalProvider<
          GetProfileUseCase,
          GetProfileUseCase,
          GetProfileUseCase
        >
    with $Provider<GetProfileUseCase> {
  GetProfileUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getProfileUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getProfileUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetProfileUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetProfileUseCase create(Ref ref) {
    return getProfileUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetProfileUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetProfileUseCase>(value),
    );
  }
}

String _$getProfileUseCaseHash() => r'4ca5227c3643973b574558ffeeca3aa9c10c4dce';

@ProviderFor(acceptConsentUseCase)
final acceptConsentUseCaseProvider = AcceptConsentUseCaseProvider._();

final class AcceptConsentUseCaseProvider
    extends
        $FunctionalProvider<
          AcceptConsentUseCase,
          AcceptConsentUseCase,
          AcceptConsentUseCase
        >
    with $Provider<AcceptConsentUseCase> {
  AcceptConsentUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'acceptConsentUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$acceptConsentUseCaseHash();

  @$internal
  @override
  $ProviderElement<AcceptConsentUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AcceptConsentUseCase create(Ref ref) {
    return acceptConsentUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AcceptConsentUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AcceptConsentUseCase>(value),
    );
  }
}

String _$acceptConsentUseCaseHash() =>
    r'6d939755ed5b7c6f954a1c836ee456bf02fa010f';
