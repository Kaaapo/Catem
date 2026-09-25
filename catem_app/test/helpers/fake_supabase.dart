import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// SupabaseClient real sobre un http.Client falso: permite probar los
/// datasources sin red y verificar los requests que generan.
class FakeSupabase {
  FakeSupabase() {
    client = SupabaseClient(
      baseUrl,
      'fake-key',
      httpClient: MockClient(_handle),
      authOptions: AuthClientOptions(pkceAsyncStorage: _InMemoryAsyncStorage()),
    );
  }

  static const baseUrl = 'http://fake.supabase.local';

  late final SupabaseClient client;
  final requests = <http.Request>[];
  final _routes = <String, (int, Object?)>{};

  /// Registra la respuesta para `METHOD /path` (sin query string).
  void on(String method, String path, Object? body, {int status = 200}) {
    _routes['${method.toUpperCase()} $path'] = (status, body);
  }

  http.Request requestTo(String method, String path) => requests.firstWhere(
    (r) => r.method == method.toUpperCase() && r.url.path == path,
  );

  Map<String, dynamic> jsonBodyOf(http.Request request) =>
      jsonDecode(request.body) as Map<String, dynamic>;

  Future<void> dispose() => client.dispose();

  Future<http.Response> _handle(http.Request request) async {
    requests.add(request);
    final route = _routes['${request.method} ${request.url.path}'];
    if (route == null) {
      return http.Response(
        jsonEncode({'message': 'sin ruta falsa para ${request.method} ${request.url.path}'}),
        404,
        headers: const {'content-type': 'application/json'},
      );
    }
    final (status, body) = route;
    return http.Response(
      body == null ? '' : jsonEncode(body),
      status,
      headers: const {'content-type': 'application/json'},
      request: request,
    );
  }
}

class _InMemoryAsyncStorage extends GotrueAsyncStorage {
  final _items = <String, String>{};

  @override
  Future<String?> getItem({required String key}) async => _items[key];

  @override
  Future<void> setItem({required String key, required String value}) async =>
      _items[key] = value;

  @override
  Future<void> removeItem({required String key}) async => _items.remove(key);
}

/// JWT sintactico (no firmado) con exp lejano para que gotrue lo acepte.
String fakeJwt({String sub = 'user-1'}) {
  String encode(Map<String, Object> json) =>
      base64Url.encode(utf8.encode(jsonEncode(json))).replaceAll('=', '');
  final header = encode({'alg': 'HS256', 'typ': 'JWT'});
  final payload = encode({
    'sub': sub,
    'role': 'authenticated',
    'exp': DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch ~/ 1000,
  });
  return '$header.$payload.firma';
}

Map<String, dynamic> fakeUserJson({
  String id = 'user-1',
  String? email = 'ana@catem.app',
  String? phone,
  bool emailConfirmed = false,
  bool phoneConfirmed = false,
}) {
  return {
    'id': id,
    'aud': 'authenticated',
    'role': 'authenticated',
    'email': email,
    'phone': phone ?? '',
    'email_confirmed_at': emailConfirmed ? '2026-09-24T15:00:00Z' : null,
    'phone_confirmed_at': phoneConfirmed ? '2026-09-24T15:00:00Z' : null,
    'app_metadata': {'provider': 'email', 'providers': ['email']},
    'user_metadata': <String, dynamic>{},
    'identities': <Map<String, dynamic>>[],
    'created_at': '2026-09-24T15:00:00Z',
    'updated_at': '2026-09-24T15:00:00Z',
    'is_anonymous': false,
  };
}

Map<String, dynamic> fakeSessionJson({Map<String, dynamic>? user}) {
  final u = user ?? fakeUserJson(emailConfirmed: true);
  return {
    'access_token': fakeJwt(sub: u['id'] as String),
    'token_type': 'bearer',
    'expires_in': 3600,
    'refresh_token': 'refresh-1',
    'user': u,
  };
}
