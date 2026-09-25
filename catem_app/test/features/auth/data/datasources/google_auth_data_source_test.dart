import 'package:catem_app/core/errors/exceptions.dart';
import 'package:catem_app/features/auth/data/datasources/google_auth_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

void main() {
  late MockGoogleSignIn googleSignIn;
  late MockGoogleSignInAccount account;
  late MockGoogleSignInAuthentication authentication;

  setUp(() {
    googleSignIn = MockGoogleSignIn();
    account = MockGoogleSignInAccount();
    authentication = MockGoogleSignInAuthentication();
    when(
      () => googleSignIn.initialize(
        clientId: any(named: 'clientId'),
        serverClientId: any(named: 'serverClientId'),
      ),
    ).thenAnswer((_) async {});
    when(() => googleSignIn.authenticate()).thenAnswer((_) async => account);
    when(() => googleSignIn.signOut()).thenAnswer((_) async {});
    when(() => account.authentication).thenReturn(authentication);
  });

  test('inicializa una vez con el web client id y devuelve el idToken', () async {
    when(() => authentication.idToken).thenReturn('id-token');
    final dataSource = GoogleSignInAuthDataSource(
      'web-id',
      'ios-id',
      googleSignIn: googleSignIn,
    );

    expect(await dataSource.signIn(), 'id-token');
    expect(await dataSource.signIn(), 'id-token');

    verify(
      () => googleSignIn.initialize(clientId: 'ios-id', serverClientId: 'web-id'),
    ).called(1);
  });

  test('falla con mensaje claro si no hay GOOGLE_WEB_CLIENT_ID', () async {
    final dataSource = GoogleSignInAuthDataSource('', null, googleSignIn: googleSignIn);

    expect(dataSource.signIn, throwsA(isA<ServerException>()));
  });

  test('falla si Google no devuelve idToken', () async {
    when(() => authentication.idToken).thenReturn(null);
    final dataSource = GoogleSignInAuthDataSource('web-id', null, googleSignIn: googleSignIn);

    expect(dataSource.signIn, throwsA(isA<ServerException>()));
  });

  test('signOut solo llama a Google si se inicializo', () async {
    when(() => authentication.idToken).thenReturn('id-token');
    final dataSource = GoogleSignInAuthDataSource('web-id', null, googleSignIn: googleSignIn);

    await dataSource.signOut();
    verifyNever(() => googleSignIn.signOut());

    await dataSource.signIn();
    await dataSource.signOut();
    verify(() => googleSignIn.signOut()).called(1);
  });
}
