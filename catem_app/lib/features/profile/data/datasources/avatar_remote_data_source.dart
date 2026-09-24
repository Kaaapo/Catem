import 'dart:io';
import 'dart:typed_data';

import 'package:catem_app/core/errors/exceptions.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Comprime a WebP y garantiza < 500KB antes de subir (CATEM-80).
abstract interface class ImageCompressor {
  Future<Uint8List> compressToWebp(File file, {required int maxBytes});
}

class FlutterImageCompressor implements ImageCompressor {
  const FlutterImageCompressor();

  @override
  Future<Uint8List> compressToWebp(File file, {required int maxBytes}) async {
    for (final quality in const [85, 70, 55, 40, 25]) {
      final bytes = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        quality: quality,
        minWidth: 1024,
        minHeight: 1024,
        format: CompressFormat.webp,
      );
      if (bytes == null) {
        throw const CacheException('No se pudo comprimir la imagen');
      }
      if (bytes.lengthInBytes <= maxBytes) return bytes;
    }
    throw const CacheException('La imagen sigue pesando mas de 500KB');
  }
}

abstract interface class AvatarRemoteDataSource {
  /// Sube el avatar a avatars/{userId}/avatar_{timestamp}.webp y devuelve el path.
  Future<String> uploadAvatar(File file, String userId);

  /// URL firmada temporal (el bucket es privado).
  Future<String> getAvatarUrl(String path);

  Future<void> deleteAvatar(String path);
}

class SupabaseAvatarRemoteDataSource implements AvatarRemoteDataSource {
  const SupabaseAvatarRemoteDataSource(
    this._client,
    this._compressor, {
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  static const String bucket = 'avatars';
  static const int maxBytes = 500 * 1024;
  static const int signedUrlSeconds = 60 * 60;

  final SupabaseClient _client;
  final ImageCompressor _compressor;
  final DateTime Function() _now;

  @override
  Future<String> uploadAvatar(File file, String userId) async {
    final bytes = await _compressor.compressToWebp(file, maxBytes: maxBytes);
    final path = '$userId/avatar_${_now().millisecondsSinceEpoch}.webp';
    await _client.storage
        .from(bucket)
        .uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(contentType: 'image/webp', upsert: true),
        );
    return path;
  }

  @override
  Future<String> getAvatarUrl(String path) =>
      _client.storage.from(bucket).createSignedUrl(path, signedUrlSeconds);

  @override
  Future<void> deleteAvatar(String path) =>
      _client.storage.from(bucket).remove([path]);
}
