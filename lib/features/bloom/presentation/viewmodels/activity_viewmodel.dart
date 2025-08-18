import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bloom_health_app/features/bloom/domain/entities/activity_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/usecases/activity_usecases/get_activity_entries.dart';
import 'package:bloom_health_app/features/bloom/domain/usecases/activity_usecases/add_activity_entry_usecase.dart';

class ActivityViewModel extends StateNotifier<AsyncValue<List<ActivityEntity>>> {
  final AddActivityEntry addActivityEntry;
  final GetActivityEntries getActivityEntry;

  int? lastExerciseMinutes; // Track the last known exercise minutes
  StreamSubscription<List<ActivityEntity>>? _subscription;

  // Stream-based constructor
  ActivityViewModel.streamBased({
    required Stream<List<ActivityEntity>> activityStream,
    required this.addActivityEntry,
    required this.getActivityEntry,
  }) : super(const AsyncValue.loading()) {
    _subscription = activityStream.listen(
          (entries) {
        final latest = entries.isNotEmpty ? entries.last.exerciseMin : null;

        // Only update if changed
        if (latest != lastExerciseMinutes) {
          lastExerciseMinutes = latest;
          state = AsyncValue.data(entries);
        }
      },
      onError: (err, stack) {
        state = AsyncValue.error(err, stack);
      },
    );
  }

  // Load a specific range of activities
  Future<void> loadRange({DateTime? from, DateTime? to}) async {
    state = const AsyncValue.loading();
    try {
      final entries = await getActivityEntry(from: from, to: to);
      lastExerciseMinutes = entries.isNotEmpty ? entries.last.exerciseMin : null;
      state = AsyncValue.data(entries);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // Add a new activity entry
  Future<void> addEntry(ActivityEntity entry) async {
    try {
      await addActivityEntry(entry);
      // No manual reload needed — stream updates automatically
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
