import 'package:catem_app/core/network/network_info.dart';
import 'package:catem_app/features/auth/data/datasources/apple_auth_data_source.dart';
import 'package:catem_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:catem_app/features/auth/data/datasources/google_auth_data_source.dart';
import 'package:catem_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:catem_app/features/notifications/data/datasources/device_token_remote_data_source.dart';
import 'package:catem_app/features/notifications/data/datasources/fcm_remote_data_source.dart';
import 'package:catem_app/features/notifications/domain/repositories/push_notifications_repository.dart';
import 'package:catem_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:catem_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:catem_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockGoogleAuthDataSource extends Mock implements GoogleAuthDataSource {}

class MockAppleAuthDataSource extends Mock implements AppleAuthDataSource {}

class MockPushNotificationsRepository extends Mock
    implements PushNotificationsRepository {}

class MockFcmRemoteDataSource extends Mock implements FcmRemoteDataSource {}

class MockDeviceTokenRemoteDataSource extends Mock
    implements DeviceTokenRemoteDataSource {}

class MockProfileRepository extends Mock implements ProfileRepository {}

class MockProfileRemoteDataSource extends Mock
    implements ProfileRemoteDataSource {}

class MockProfileLocalDataSource extends Mock
    implements ProfileLocalDataSource {}
