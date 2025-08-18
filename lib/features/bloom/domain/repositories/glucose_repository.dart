import 'package:bloom_health_app/features/bloom/domain/entities/glucose_entity.dart';

abstract class GlucoseRepository {
  Future<void> addGlucoseEntry(GlucoseEntity entry);
  Future<List<GlucoseEntity>> getGlucoseEntries({DateTime? from, DateTime? to});

  // for stream
  Stream<List<GlucoseEntity>> watchGlucoseEntries();
}
