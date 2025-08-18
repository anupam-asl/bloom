import 'package:bloom_health_app/features/bloom/domain/entities/sleep_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/repositories/sleep_repository.dart';

import 'package:bloom_health_app/features/bloom/data/datasources/sleep_local_data_source.dart';

class SleepRepositoryImpl implements SleepRepository {
  final SleepLocalDataSource localDataSource;

  SleepRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addSleepEntry(SleepEntity entry) async {
    await localDataSource.insertSleep(entry);
  }

  @override
  Future<List<SleepEntity>> getSleepEntries({
    DateTime? from,
    DateTime? to,
  }) async {
    return await localDataSource.fetchSleep(from: from, to: to);
  }

  @override
  Stream<List<SleepEntity>> watchSleepEntries() {
    // Simple polling stream (like glucose)
    return Stream.periodic(const Duration(seconds: 1))
        .asyncMap((_) => localDataSource.fetchSleep());
  }
}
