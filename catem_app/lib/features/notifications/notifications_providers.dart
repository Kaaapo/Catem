import 'package:catem_app/core/network/supabase_provider.dart';
import 'package:catem_app/features/notifications/data/datasources/device_token_remote_data_source.dart';
import 'package:catem_app/features/notifications/data/datasources/fcm_remote_data_source.dart';
import 'package:catem_app/features/notifications/data/repositories/push_notifications_repository_impl.dart';
import 'package:catem_app/features/notifications/domain/repositories/push_notifications_repository.dart';
import 'package:catem_app/features/notifications/domain/usecases/register_device_for_push_use_case.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_providers.g.dart';

@riverpod
FcmRemoteDataSource fcmRemoteDataSource(Ref ref) =>
    FirebaseFcmRemoteDataSource(FirebaseMessaging.instance);

@riverpod
DeviceTokenRemoteDataSource deviceTokenRemoteDataSource(Ref ref) =>
    SupabaseDeviceTokenRemoteDataSource(ref.watch(supabaseClientProvider));

@riverpod
PushNotificationsRepository pushNotificationsRepository(Ref ref) {
  return PushNotificationsRepositoryImpl(
    ref.watch(fcmRemoteDataSourceProvider),
    ref.watch(deviceTokenRemoteDataSourceProvider),
    defaultTargetPlatform == TargetPlatform.iOS ? 'ios' : 'android',
  );
}

@riverpod
RegisterDeviceForPushUseCase registerDeviceForPushUseCase(Ref ref) =>
    RegisterDeviceForPushUseCase(ref.watch(pushNotificationsRepositoryProvider));
