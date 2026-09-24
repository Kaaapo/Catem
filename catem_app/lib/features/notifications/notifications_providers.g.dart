// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fcmRemoteDataSource)
final fcmRemoteDataSourceProvider = FcmRemoteDataSourceProvider._();

final class FcmRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          FcmRemoteDataSource,
          FcmRemoteDataSource,
          FcmRemoteDataSource
        >
    with $Provider<FcmRemoteDataSource> {
  FcmRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fcmRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fcmRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<FcmRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FcmRemoteDataSource create(Ref ref) {
    return fcmRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FcmRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FcmRemoteDataSource>(value),
    );
  }
}

String _$fcmRemoteDataSourceHash() =>
    r'bd232eefd376e3ee7af65d4866b62c4cc86b4a00';

@ProviderFor(deviceTokenRemoteDataSource)
final deviceTokenRemoteDataSourceProvider =
    DeviceTokenRemoteDataSourceProvider._();

final class DeviceTokenRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          DeviceTokenRemoteDataSource,
          DeviceTokenRemoteDataSource,
          DeviceTokenRemoteDataSource
        >
    with $Provider<DeviceTokenRemoteDataSource> {
  DeviceTokenRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceTokenRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceTokenRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<DeviceTokenRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceTokenRemoteDataSource create(Ref ref) {
    return deviceTokenRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceTokenRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceTokenRemoteDataSource>(value),
    );
  }
}

String _$deviceTokenRemoteDataSourceHash() =>
    r'4f368e5097be741eb868a92a46c8251a69d89025';

@ProviderFor(pushNotificationsRepository)
final pushNotificationsRepositoryProvider =
    PushNotificationsRepositoryProvider._();

final class PushNotificationsRepositoryProvider
    extends
        $FunctionalProvider<
          PushNotificationsRepository,
          PushNotificationsRepository,
          PushNotificationsRepository
        >
    with $Provider<PushNotificationsRepository> {
  PushNotificationsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushNotificationsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushNotificationsRepositoryHash();

  @$internal
  @override
  $ProviderElement<PushNotificationsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PushNotificationsRepository create(Ref ref) {
    return pushNotificationsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PushNotificationsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PushNotificationsRepository>(value),
    );
  }
}

String _$pushNotificationsRepositoryHash() =>
    r'89358baed162a63dfaf91165ad87be034b0b175e';

@ProviderFor(registerDeviceForPushUseCase)
final registerDeviceForPushUseCaseProvider =
    RegisterDeviceForPushUseCaseProvider._();

final class RegisterDeviceForPushUseCaseProvider
    extends
        $FunctionalProvider<
          RegisterDeviceForPushUseCase,
          RegisterDeviceForPushUseCase,
          RegisterDeviceForPushUseCase
        >
    with $Provider<RegisterDeviceForPushUseCase> {
  RegisterDeviceForPushUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerDeviceForPushUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerDeviceForPushUseCaseHash();

  @$internal
  @override
  $ProviderElement<RegisterDeviceForPushUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RegisterDeviceForPushUseCase create(Ref ref) {
    return registerDeviceForPushUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegisterDeviceForPushUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegisterDeviceForPushUseCase>(value),
    );
  }
}

String _$registerDeviceForPushUseCaseHash() =>
    r'a2f74a9237cd001e3dc72ce8a5a50976e0e36f0a';
