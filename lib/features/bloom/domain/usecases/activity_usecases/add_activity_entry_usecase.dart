import 'package:bloom_health_app/features/bloom/domain/entities/activity_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/repositories/activity_repository.dart';


class AddActivityEntry {
  final ActivityRepository repository;

  AddActivityEntry(this.repository);

  Future<void> call(ActivityEntity entry) async {
    return repository.addActivityEntry(entry);
  }
}
