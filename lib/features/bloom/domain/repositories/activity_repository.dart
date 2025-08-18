import 'package:bloom_health_app/features/bloom/domain/entities/activity_entity.dart';


abstract class ActivityRepository {

  Future<void> addActivityEntry(ActivityEntity entry);

  Future<List<ActivityEntity>> getActivityEntries({DateTime? from, DateTime? to});

  Stream<List<ActivityEntity>> watchActivityEntries();
}
