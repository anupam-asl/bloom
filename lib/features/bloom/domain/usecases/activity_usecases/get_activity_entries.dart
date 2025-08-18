import 'package:bloom_health_app/features/bloom/domain/entities/activity_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/repositories/activity_repository.dart';

class GetActivityEntries {
  final ActivityRepository repository;

  GetActivityEntries(this.repository);

  Future<List<ActivityEntity>> call({DateTime? from, DateTime? to}) async {
    return repository.getActivityEntries(from: from, to: to);
  }
}
