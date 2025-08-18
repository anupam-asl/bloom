import '../entities/sleep_entity.dart';

abstract class SleepRepository {
  Future<void> addSleepEntry(SleepEntity entry);
  Future<List<SleepEntity>> getSleepEntries({DateTime? from, DateTime? to});

  // for stream
  Stream<List<SleepEntity>> watchSleepEntries();
}
