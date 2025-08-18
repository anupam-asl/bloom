import 'package:bloom_health_app/features/bloom/domain/entities/activity_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/repositories/activity_repository.dart';
import 'package:bloom_health_app/features/bloom/data/datasources/activity_local_datasource.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityLocalDataSource localDataSource;

  ActivityRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addActivityEntry(ActivityEntity entry) async {
    await localDataSource.insertActivity(entry);
  }

  @override
  Future<List<ActivityEntity>> getActivityEntries({
    DateTime? from,
    DateTime? to,
  }) async {
    return await localDataSource.fetchActivities(from: from, to: to);
  }

  @override
  Stream<List<ActivityEntity>> watchActivityEntries() {
    // Poll every 1 second for changes, like glucose/food
    return Stream.periodic(const Duration(seconds: 1))
        .asyncMap((_) => localDataSource.fetchActivities());
  }
}
