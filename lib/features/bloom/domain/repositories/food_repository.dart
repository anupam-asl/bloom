import 'package:bloom_health_app/features/bloom/domain/entities/food_entity.dart';

abstract class FoodRepository {
  Future<void> addFoodEntry(FoodEntity entry);
  Future<List<FoodEntity>> getFoodEntries({DateTime? from, DateTime? to});

  Stream<List<FoodEntity>> watchFoodEntries();
}
