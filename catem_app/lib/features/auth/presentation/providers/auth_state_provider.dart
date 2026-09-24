import 'package:catem_app/features/auth/auth_providers.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

@riverpod
Stream<UserEntity?> authState(Ref ref) =>
    ref.watch(authRepositoryProvider).authStateChanges;
