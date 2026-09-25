import 'package:catem_app/core/errors/exceptions.dart';
import 'package:catem_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:catem_app/features/auth/domain/entities/auth_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../helpers/fake_supabase.dart';

void main() {
  late FakeSupabase fake;
  late SupabaseAuthRemoteDataSource dataSource;

  setUp(() {
    fake = FakeSupabase();
    dataSource = SupabaseAuthRemoteDataSource(fake.client);
  });

  tearDown(() => fake.dispose());

  Future<void> login() async {
    fake.on('POST', '/auth/v1/token', fakeSessionJson());
    await dataSource.signInWithEmail(email: 'ana@catem.app', password: 'x');
  }

  test('signUpWithEmail devuelve el usuario sin confirmar y pide redirect', () async {
    fake.on('POST', '/auth/v1/signup', fakeUserJson());

    final user = await dataSource.signUpWithEmail(
      email: 'ana@catem.app',
      password: 'secreto123',
    );

    expect(user.id, 'user-1');
    expect(user.isEmailConfirmed, isFalse);
    final request = fake.requestTo('POST', '/auth/v1/signup');
    expect(fake.jsonBodyOf(request)['email'], 'ana@catem.app');
    expect(
      request.url.queryParameters['redirect_to'],
      SupabaseAuthRemoteDataSource.verifyEmailRedirect,
    );
  });

  test('signInWithEmail devuelve el usuario y deja sesion activa', () async {
    await login();

    expect(dataSource.currentUser?.email, 'ana@catem.app');
    expect(dataSource.currentUser?.isEmailConfirmed, isTrue);
    expect(
      fake.requestTo('POST', '/auth/v1/token').url.queryParameters['grant_type'],
      'password',
    );
  });

  test('requestPhoneOtp envia el telefono al endpoint de OTP', () async {
    fake.on('POST', '/auth/v1/otp', <String, dynamic>{});

    await dataSource.requestPhoneOtp(phone: '+573001234567');

    expect(
      fake.jsonBodyOf(fake.requestTo('POST', '/auth/v1/otp'))['phone'],
      '+573001234567',
    );
  });

  test('verifyPhoneOtp verifica tipo sms y devuelve usuario', () async {
    fake.on(
      'POST',
      '/auth/v1/verify',
      fakeSessionJson(
        user: fakeUserJson(email: null, phone: '573001234567', phoneConfirmed: true),
      ),
    );

    final user = await dataSource.verifyPhoneOtp(
      phone: '+573001234567',
      code: '123456',
    );

    expect(user.isPhoneConfirmed, isTrue);
    final body = fake.jsonBodyOf(fake.requestTo('POST', '/auth/v1/verify'));
    expect(body['type'], 'sms');
    expect(body['token'], '123456');
  });

  test('signInWithIdToken manda provider, id_token y nonce', () async {
    fake.on('POST', '/auth/v1/token', fakeSessionJson());

    await dataSource.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: 'apple-token',
      nonce: 'nonce-1',
    );

    final request = fake.requestTo('POST', '/auth/v1/token');
    expect(request.url.queryParameters['grant_type'], 'id_token');
    final body = fake.jsonBodyOf(request);
    expect(body['provider'], 'apple');
    expect(body['id_token'], 'apple-token');
    expect(body['nonce'], 'nonce-1');
  });

  test('sendPasswordReset usa el deep link de reset como redirect', () async {
    fake.on('POST', '/auth/v1/recover', <String, dynamic>{});

    await dataSource.sendPasswordReset(email: 'ana@catem.app');

    final request = fake.requestTo('POST', '/auth/v1/recover');
    expect(fake.jsonBodyOf(request)['email'], 'ana@catem.app');
    expect(
      request.url.queryParameters['redirect_to'],
      'catem://auth-callback/reset-password',
    );
  });

  test('updatePassword hace PUT /user con la sesion activa', () async {
    await login();
    fake.on('PUT', '/auth/v1/user', fakeUserJson(emailConfirmed: true));

    final user = await dataSource.updatePassword(newPassword: 'nueva12345');

    expect(user.id, 'user-1');
    final request = fake.requestTo('PUT', '/auth/v1/user');
    expect(fake.jsonBodyOf(request)['password'], 'nueva12345');
    expect(request.headers['Authorization'], startsWith('Bearer '));
  });

  test('resendEmailConfirmation reenvia el correo de signup', () async {
    fake.on('POST', '/auth/v1/resend', <String, dynamic>{});

    await dataSource.resendEmailConfirmation(email: 'ana@catem.app');

    final body = fake.jsonBodyOf(fake.requestTo('POST', '/auth/v1/resend'));
    expect(body['type'], 'signup');
    expect(body['email'], 'ana@catem.app');
  });

  test('refreshCurrentUser es null sin sesion y consulta /user con sesion', () async {
    expect(await dataSource.refreshCurrentUser(), isNull);

    await login();
    fake.on('GET', '/auth/v1/user', fakeUserJson(emailConfirmed: true));

    final user = await dataSource.refreshCurrentUser();

    expect(user?.isEmailConfirmed, isTrue);
  });

  test('authStateChanges y authEvents reflejan el login', () async {
    final users = <String?>[];
    final userSub = dataSource.authStateChanges.listen((u) => users.add(u?.id));
    addTearDown(userSub.cancel);
    final events = <AuthEvent>[];
    final eventSub = dataSource.authEvents.listen(events.add);
    addTearDown(eventSub.cancel);

    await login();
    await Future<void>.delayed(Duration.zero);

    expect(users, contains('user-1'));
    expect(events, contains(AuthEvent.signedIn));
  });

  test('signOut cierra la sesion', () async {
    await login();
    fake.on('POST', '/auth/v1/logout', null, status: 204);

    await dataSource.signOut();

    expect(dataSource.currentUser, isNull);
  });

  test('generateRawNonce devuelve un valor no vacio y distinto cada vez', () {
    final a = dataSource.generateRawNonce();
    final b = dataSource.generateRawNonce();

    expect(a, isNotEmpty);
    expect(a, isNot(b));
  });

  test('lanza ServerException si Supabase responde sin usuario', () async {
    fake.on('POST', '/auth/v1/verify', <String, dynamic>{});

    expect(
      () => dataSource.verifyPhoneOtp(phone: '+573001234567', code: '000000'),
      throwsA(isA<ServerException>()),
    );
  });
}
