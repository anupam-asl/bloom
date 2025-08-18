import 'package:bloom_health_app/features/bloom/domain/entities/sleep_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/repositories/sleep_repository.dart';

class GetSleepEntries {
  final SleepRepository repository;

  GetSleepEntries(this.repository);

  Future<List<SleepEntity>> call({DateTime? from, DateTime? to}) async {
    return repository.getSleepEntries(from: from, to: to);
  }
}
