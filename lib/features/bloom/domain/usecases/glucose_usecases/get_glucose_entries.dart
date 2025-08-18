import 'package:bloom_health_app/features/bloom/domain/entities/glucose_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/repositories/glucose_repository.dart';

class GetGlucoseEntries {
  final GlucoseRepository repository;

  GetGlucoseEntries(this.repository);

  Future<List<GlucoseEntity>> call({DateTime? from, DateTime? to}) async {
    return repository.getGlucoseEntries(from: from, to: to);
  }
}
