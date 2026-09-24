import 'dart:async';

import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/network/network_info.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:catem_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:catem_app/features/profile/domain/entities/profile_entity.dart';
import 'package:catem_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Cache-first (RNF-07): lee de drift para render inmediato y sincroniza con
/// Supabase en background cuando hay red.
class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._remote, this._local, this._network);

  final ProfileRemoteDataSource _remote;
  final ProfileLocalDataSource _local;
  final NetworkInfo _network;

  @override
  Future<Result<ProfileEntity?>> getProfile(
    String userId, {
    bool forceRefresh = false,
  }) async {
    try {
      if (!forceRefresh) {
        final cached = await _local.getById(userId);
        if (cached != null) {
          unawaited(_syncFromRemote(userId));
          return Success(cached);
        }
      }
      if (!await _network.isConnected) {
        return const Failed(NetworkFailure());
      }
      return Success(await _syncFromRemote(userId));
    } on PostgrestException catch (e) {
      return Failed(ServerFailure(e.message));
    } on Exception catch (e) {
      return Failed(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<ProfileEntity?> watchProfile(String userId) => _local.watchById(userId);

  @override
  Future<Result<ProfileEntity>> acceptConsent({
    required String userId,
    required String termsVersion,
  }) async {
    try {
      if (!await _network.isConnected) {
        return const Failed(NetworkFailure());
      }
      final profile = await _remote.acceptConsent(
        userId: userId,
        termsVersion: termsVersion,
      );
      await _local.upsert(profile);
      return Success(profile);
    } on PostgrestException catch (e) {
      return Failed(ServerFailure(e.message));
    } on Exception catch (e) {
      return Failed(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> clearCache() => _local.clear();

  Future<ProfileEntity?> _syncFromRemote(String userId) async {
    if (!await _network.isConnected) return null;
    final remote = await _remote.getById(userId);
    if (remote != null) {
      await _local.upsert(remote);
    }
    return remote;
  }
}
