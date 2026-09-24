import 'package:catem_app/features/auth/auth_providers.dart';
import 'package:catem_app/features/auth/domain/entities/auth_event.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

/// Usuario actual; supabase_flutter emite la sesion persistida al suscribirse.
@riverpod
Stream<UserEntity?> authState(Ref ref) =>
    ref.watch(authRepositoryProvider).authStateChanges;

@riverpod
Stream<AuthEvent> authEvents(Ref ref) =>
    ref.watch(authRepositoryProvider).authEvents;
