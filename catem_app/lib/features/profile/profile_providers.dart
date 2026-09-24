import 'package:catem_app/core/local_database/local_database_provider.dart';
import 'package:catem_app/core/network/network_info.dart';
import 'package:catem_app/core/network/supabase_provider.dart';
import 'package:catem_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:catem_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:catem_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:catem_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:catem_app/features/profile/domain/usecases/accept_consent_use_case.dart';
import 'package:catem_app/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_providers.g.dart';

@riverpod
ProfileRemoteDataSource profileRemoteDataSource(Ref ref) =>
    SupabaseProfileRemoteDataSource(ref.watch(supabaseClientProvider));

@riverpod
ProfileLocalDataSource profileLocalDataSource(Ref ref) =>
    DriftProfileLocalDataSource(ref.watch(appDatabaseProvider).cachedProfileDao);

@riverpod
ProfileRepository profileRepository(Ref ref) => ProfileRepositoryImpl(
  ref.watch(profileRemoteDataSourceProvider),
  ref.watch(profileLocalDataSourceProvider),
  ref.watch(networkInfoProvider),
);

@riverpod
GetProfileUseCase getProfileUseCase(Ref ref) =>
    GetProfileUseCase(ref.watch(profileRepositoryProvider));

@riverpod
AcceptConsentUseCase acceptConsentUseCase(Ref ref) =>
    AcceptConsentUseCase(ref.watch(profileRepositoryProvider));
