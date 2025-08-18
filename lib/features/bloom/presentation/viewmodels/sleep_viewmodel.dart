import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloom_health_app/features/bloom/domain/entities/sleep_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/usecases/sleep_usecases/add_sleep_entry.dart';
import 'package:bloom_health_app/features/bloom/domain/usecases/sleep_usecases/get_sleep_entries.dart';

class SleepViewModel extends StateNotifier<AsyncValue<List<SleepEntity>>> {
  final AddSleepEntry addSleepEntry;
  final GetSleepEntries getSleepEntries;
  StreamSubscription<List<SleepEntity>>? _subscription;

  SleepViewModel.streamBased({
    required Stream<List<SleepEntity>> sleepStream,
    required this.addSleepEntry,
    required this.getSleepEntries,
  }) : super(const AsyncValue.loading()) {
    _subscription = sleepStream.listen(
          (entries) {
        state = AsyncValue.data(entries);
      },
      onError: (err, stack) {
        state = AsyncValue.error(err, stack);
      },
    );
  }

  Future<void> loadRange({DateTime? from, DateTime? to}) async {
    state = const AsyncValue.loading();
    try {
      final entries = await getSleepEntries(from: from, to: to);
      state = AsyncValue.data(entries);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addEntry(SleepEntity entry) async {
    try {
      await addSleepEntry(entry);
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
