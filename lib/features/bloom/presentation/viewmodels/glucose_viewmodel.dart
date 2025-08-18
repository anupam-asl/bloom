import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloom_health_app/features/bloom/domain/entities/glucose_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/usecases/glucose_usecases/get_glucose_entries.dart';
import 'package:bloom_health_app/features/bloom/domain/usecases/glucose_usecases/add_glucose_entry_usecase.dart';

class GlucoseViewModel extends StateNotifier<AsyncValue<List<GlucoseEntity>>> {
  final AddGlucoseEntry addGlucoseEntry;
  final GetGlucoseEntries getGlucoseEntry;
  double? lastGlucoseValue;

  StreamSubscription<List<GlucoseEntity>>? _subscription;

  // Stream-based constructor
  GlucoseViewModel.streamBased({
    required Stream<List<GlucoseEntity>> glucoseStream,
    required this.addGlucoseEntry,
    required this.getGlucoseEntry,
  }) : super(const AsyncValue.loading()) {
    _subscription = glucoseStream.listen(
          (entries) {
        final latest = entries.isNotEmpty
            ? entries.last.valueMgDl.toDouble()
            : null;

        // Only update if changed
        if (latest != lastGlucoseValue) {
          lastGlucoseValue = latest;
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
      final entries = await getGlucoseEntry(from: from, to: to);
      lastGlucoseValue = entries.isNotEmpty
          ? entries.last.valueMgDl.toDouble()
          : null;
      state = AsyncValue.data(entries);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // Add a new glucose entry
  Future<void> addEntry(GlucoseEntity entry) async {
    try {
      await addGlucoseEntry(entry);
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
