import 'dart:io';
import 'dart:typed_data';

import 'package:catem_app/features/profile/data/datasources/avatar_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../helpers/mocks.dart';

class MockImageCompressor extends Mock implements ImageCompressor {}

class MockStorageClient extends Mock implements SupabaseStorageClient {}

class MockStorageFileApi extends Mock implements StorageFileApi {}

void main() {
  late MockSupabaseClient client;
  late MockStorageClient storage;
  late MockStorageFileApi bucket;
  late MockImageCompressor compressor;
  late SupabaseAvatarRemoteDataSource dataSource;

  final file = File('avatar.jpg');
  final bytes = Uint8List.fromList([1, 2, 3]);

  setUpAll(() {
    registerFallbackValue(file);
    registerFallbackValue(Uint8List(0));
    registerFallbackValue(const FileOptions());
  });

  setUp(() {
    client = MockSupabaseClient();
    storage = MockStorageClient();
    bucket = MockStorageFileApi();
    compressor = MockImageCompressor();
    when(() => client.storage).thenReturn(storage);
    when(() => storage.from('avatars')).thenReturn(bucket);
    dataSource = SupabaseAvatarRemoteDataSource(
      client,
      compressor,
      now: () => DateTime.fromMillisecondsSinceEpoch(1700000000000),
    );
  });

  test('comprime a WebP < 500KB y sube a avatars/{userId}/avatar_{ts}.webp', () async {
    when(
      () => compressor.compressToWebp(any(), maxBytes: any(named: 'maxBytes')),
    ).thenAnswer((_) async => bytes);
    when(
      () => bucket.uploadBinary(
        any(),
        any(),
        fileOptions: any(named: 'fileOptions'),
      ),
    ).thenAnswer((_) async => 'ok');

    final path = await dataSource.uploadAvatar(file, 'user-1');

    expect(path, 'user-1/avatar_1700000000000.webp');
    verify(() => compressor.compressToWebp(file, maxBytes: 500 * 1024)).called(1);
    final captured = verify(
      () => bucket.uploadBinary(
        captureAny(),
        bytes,
        fileOptions: captureAny(named: 'fileOptions'),
      ),
    ).captured;
    expect(captured.first, path);
    expect((captured.last as FileOptions).contentType, 'image/webp');
  });

  test('getAvatarUrl devuelve una URL firmada de 1 hora', () async {
    when(() => bucket.createSignedUrl('user-1/a.webp', 3600))
        .thenAnswer((_) async => 'https://signed');

    expect(await dataSource.getAvatarUrl('user-1/a.webp'), 'https://signed');
  });

  test('deleteAvatar borra el objeto del bucket', () async {
    when(() => bucket.remove(['user-1/a.webp'])).thenAnswer((_) async => []);

    await dataSource.deleteAvatar('user-1/a.webp');

    verify(() => bucket.remove(['user-1/a.webp'])).called(1);
  });
}
