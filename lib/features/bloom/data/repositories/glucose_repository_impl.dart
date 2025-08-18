import 'package:bloom_health_app/features/bloom/domain/entities/glucose_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/repositories/glucose_repository.dart';

import 'package:bloom_health_app/features/bloom/data/datasources/glucose_local_data_source.dart';

class GlucoseRepositoryImpl implements GlucoseRepository {
  final GlucoseLocalDataSource localDataSource;

  GlucoseRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addGlucoseEntry(GlucoseEntity entry) async {
    await localDataSource.insertGlucose(entry);
  }

  @override
  Future<List<GlucoseEntity>> getGlucoseEntries({
    DateTime? from,
    DateTime? to,
  }) async {
    return await localDataSource.fetchGlucose(from: from, to: to);
  }

  @override
  Stream<List<GlucoseEntity>> watchGlucoseEntries() {
    // Poll every 1 second for changes (basic version)
    return Stream.periodic(const Duration(seconds: 1))
        .asyncMap((_) => localDataSource.fetchGlucose());
  }
}
