import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloom_health_app/features/bloom/domain/entities/food_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/usecases/food_usecases/add_food_entry_usecase.dart';
import 'package:bloom_health_app/features/bloom/domain/usecases/food_usecases/get_food_entries.dart';

class FoodViewModel extends StateNotifier<AsyncValue<List<FoodEntity>>> {
  final AddFoodEntry addFoodEntry;
  final GetFoodEntries getFoodEntries;
  int? lastCalorieValue;

  StreamSubscription<List<FoodEntity>>? _subscription;

  // Stream-based constructor
  FoodViewModel.streamBased({
    required Stream<List<FoodEntity>> foodStream,
    required this.addFoodEntry,
    required this.getFoodEntries
  }) : super(const AsyncValue.loading()) {
    _subscription = foodStream.listen(
          (entries) {
        final latest = entries.isNotEmpty
            ? entries.last.calorie.toInt()
            : null;

        // Only update if changed
        if (latest != lastCalorieValue) {
          lastCalorieValue = latest;
          state = AsyncValue.data(entries);
        }
      },
      onError: (err, stack) {
        state = AsyncValue.error(err, stack);
      },
    );
  }

  Future<void> loadRange({DateTime? from, DateTime? to}) async {
    state = const AsyncValue.loading();
    try {
      final entries = await getFoodEntries(from: from, to: to);
      lastCalorieValue = entries.isNotEmpty
          ? entries.last.calorie.toInt()
          : null;
      state = AsyncValue.data(entries);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // Add a new food entry
  Future<void> addEntry(FoodEntity entry) async {
    try {
      await addFoodEntry(entry);
      // No manual reload — stream updates automatically
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
