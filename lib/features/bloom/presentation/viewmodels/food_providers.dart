import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import 'package:bloom_health_app/features/bloom/data/datasources/food_local_data_source.dart';
import 'package:bloom_health_app/features/bloom/data/repositories/food_repository_impl.dart';
import 'package:bloom_health_app/features/bloom/domain/entities/food_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/repositories/food_repository.dart';
import 'package:bloom_health_app/features/bloom/domain/usecases/food_usecases/get_food_entries.dart';
import 'package:bloom_health_app/features/bloom/domain/usecases/food_usecases/add_food_entry_usecase.dart';
import 'package:bloom_health_app/features/bloom/presentation/viewmodels/food_viewmodel.dart';
import 'package:bloom_health_app/core/db/database_provider.dart';



// --- DataSource provider ---
final foodLocalDataSourceProvider = Provider<FoodLocalDataSource>((ref) {
  return FoodLocalDataSourceImpl(db: ref.watch(databaseProvider));
});


// --- Repository provider ---
final foodRepositoryProvider = Provider<FoodRepository>((ref) {
  return FoodRepositoryImpl(localDataSource: ref.watch(foodLocalDataSourceProvider));
});


// --- UseCase providers ---
final getFoodEntriesProvider = Provider<GetFoodEntries>((ref) {
  return GetFoodEntries(ref.watch(foodRepositoryProvider));
});

final addFoodEntryProvider = Provider<AddFoodEntry>((ref) {
  return AddFoodEntry(ref.watch(foodRepositoryProvider));
});


// --- ViewModel provider (stream-based) ---
final foodViewModelProvider =
StateNotifierProvider<FoodViewModel, AsyncValue<List<FoodEntity>>>(
      (ref) {
    return FoodViewModel.streamBased(
      foodStream: ref.watch(foodRepositoryProvider).watchFoodEntries(),
      addFoodEntry: ref.watch(addFoodEntryProvider),
      getFoodEntries: ref.watch(getFoodEntriesProvider),
    );
  },
);

// --- Optional: direct stream provider ---
final foodStreamProvider = StreamProvider<List<FoodEntity>>((ref) {
  return ref.watch(foodRepositoryProvider).watchFoodEntries();
});
