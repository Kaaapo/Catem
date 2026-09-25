import 'package:catem_app/core/local_database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_database_provider.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
}
