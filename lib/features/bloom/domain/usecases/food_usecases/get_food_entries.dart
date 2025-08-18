import 'package:bloom_health_app/features/bloom/domain/entities/food_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/repositories/food_repository.dart';

class GetFoodEntries {
  final FoodRepository repository;

  GetFoodEntries(this.repository);

  Future<List<FoodEntity>> call({DateTime? from, DateTime? to}) async {
    return repository.getFoodEntries(from: from, to: to);
  }
}
