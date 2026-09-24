import 'package:catem_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:catem_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:catem_app/features/notifications/data/datasources/device_token_remote_data_source.dart';
import 'package:catem_app/features/notifications/data/datasources/fcm_remote_data_source.dart';
import 'package:catem_app/features/notifications/domain/repositories/push_notifications_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockPushNotificationsRepository extends Mock
    implements PushNotificationsRepository {}

class MockFcmRemoteDataSource extends Mock implements FcmRemoteDataSource {}

class MockDeviceTokenRemoteDataSource extends Mock
    implements DeviceTokenRemoteDataSource {}
