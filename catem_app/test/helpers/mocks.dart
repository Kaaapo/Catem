import 'package:catem_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:catem_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}
