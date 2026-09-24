import 'package:catem_app/core/network/supabase_provider.dart';
import 'package:catem_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:catem_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:catem_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:catem_app/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) =>
    SupabaseAuthRemoteDataSource(ref.watch(supabaseClientProvider));

@riverpod
AuthRepository authRepository(Ref ref) =>
    AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider));

@riverpod
SignUpUseCase signUpUseCase(Ref ref) =>
    SignUpUseCase(ref.watch(authRepositoryProvider));

@riverpod
SignInUseCase signInUseCase(Ref ref) =>
    SignInUseCase(ref.watch(authRepositoryProvider));

@riverpod
SignOutUseCase signOutUseCase(Ref ref) =>
    SignOutUseCase(ref.watch(authRepositoryProvider));
