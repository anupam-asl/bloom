import 'package:bloom_health_app/features/bloom/domain/entities/glucose_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/repositories/glucose_repository.dart';

class AddGlucoseEntry {
  final GlucoseRepository repository;

  AddGlucoseEntry(this.repository);

  Future<void> call(GlucoseEntity entry) async {
    return repository.addGlucoseEntry(entry);
  }
}
