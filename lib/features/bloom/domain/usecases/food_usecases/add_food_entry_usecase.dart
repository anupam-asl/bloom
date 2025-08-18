import 'package:bloom_health_app/features/bloom/domain/entities/food_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/repositories/food_repository.dart';

class AddFoodEntry {
  final FoodRepository repository;

  AddFoodEntry(this.repository);

  Future<void> call(FoodEntity entry) async {
    return repository.addFoodEntry(entry);
  }
}
