import 'package:bloom_health_app/features/bloom/domain/entities/sleep_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/repositories/sleep_repository.dart';

class AddSleepEntry {
  final SleepRepository repository;

  AddSleepEntry(this.repository);

  Future<void> call(SleepEntity entry) async {
    return repository.addSleepEntry(entry);
  }
}
