import 'package:catem_app/features/notifications/data/datasources/fcm_remote_data_source.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

NotificationSettings settings(AuthorizationStatus status) => NotificationSettings(
  alert: AppleNotificationSetting.enabled,
  announcement: AppleNotificationSetting.disabled,
  authorizationStatus: status,
  badge: AppleNotificationSetting.enabled,
  carPlay: AppleNotificationSetting.disabled,
  lockScreen: AppleNotificationSetting.enabled,
  notificationCenter: AppleNotificationSetting.enabled,
  showPreviews: AppleShowPreviewSetting.always,
  timeSensitive: AppleNotificationSetting.disabled,
  criticalAlert: AppleNotificationSetting.disabled,
  sound: AppleNotificationSetting.enabled,
  providesAppNotificationSettings: AppleNotificationSetting.disabled,
);

void main() {
  late MockFirebaseMessaging messaging;
  late FirebaseFcmRemoteDataSource dataSource;

  setUp(() {
    messaging = MockFirebaseMessaging();
    dataSource = FirebaseFcmRemoteDataSource(messaging);
  });

  test('requestPermission es true con authorized o provisional', () async {
    when(() => messaging.requestPermission())
        .thenAnswer((_) async => settings(AuthorizationStatus.authorized));
    expect(await dataSource.requestPermission(), isTrue);

    when(() => messaging.requestPermission())
        .thenAnswer((_) async => settings(AuthorizationStatus.provisional));
    expect(await dataSource.requestPermission(), isTrue);
  });

  test('requestPermission es false si el usuario niega', () async {
    when(() => messaging.requestPermission())
        .thenAnswer((_) async => settings(AuthorizationStatus.denied));

    expect(await dataSource.requestPermission(), isFalse);
  });

  test('getToken y onTokenRefresh delegan a FirebaseMessaging', () async {
    when(() => messaging.getToken()).thenAnswer((_) async => 'tok');
    when(() => messaging.onTokenRefresh).thenAnswer((_) => Stream.value('tok2'));

    expect(await dataSource.getToken(), 'tok');
    expect(await dataSource.onTokenRefresh.first, 'tok2');
  });
}
