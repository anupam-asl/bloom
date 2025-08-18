import 'package:bloom_health_app/features/bloom/domain/entities/food_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/repositories/food_repository.dart';

import 'package:bloom_health_app/features/bloom/data/datasources/food_local_data_source.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodLocalDataSource localDataSource;

  FoodRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addFoodEntry(FoodEntity entry) async {
    await localDataSource.insertFood(entry);
  }

  @override
  Future<List<FoodEntity>> getFoodEntries({
    DateTime? from,
    DateTime? to,
  }) async {
    return await localDataSource.fetchFood(from: from, to: to);
  }

  @override
  Stream<List<FoodEntity>> watchFoodEntries() {
    // Poll every 1 second for changes (same as glucose)
    return Stream.periodic(const Duration(seconds: 1))
        .asyncMap((_) => localDataSource.fetchFood());
  }

}
