import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloom_health_app/core/db/database_provider.dart';

import 'package:bloom_health_app/features/bloom/domain/entities/activity_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/repositories/activity_repository.dart';
import 'package:bloom_health_app/features/bloom/domain/usecases/activity_usecases/add_activity_entry_usecase.dart';
import 'package:bloom_health_app/features/bloom/domain/usecases/activity_usecases/get_activity_entries.dart';

import 'package:bloom_health_app/features/bloom/data/datasources/activity_local_datasource.dart';
import 'package:bloom_health_app/features/bloom/data/repositories/activity_repository_impl.dart';
import 'package:bloom_health_app/features/bloom/presentation/viewmodels/activity_viewmodel.dart';


// --- DataSource provider ---
final activityLocalDataSourceProvider = Provider<ActivityLocalDataSource>((ref) {
  return ActivityLocalDataSourceImpl(db: ref.watch(databaseProvider));
});

// --- Repository provider ---
final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  return ActivityRepositoryImpl(localDataSource: ref.watch(activityLocalDataSourceProvider));
});


// --- UseCase providers ---
final getActivityEntriesProvider = Provider<GetActivityEntries>((ref) {
  return GetActivityEntries(ref.watch(activityRepositoryProvider));
});

final addActivityEntryProvider = Provider<AddActivityEntry>((ref) {
  return AddActivityEntry(ref.watch(activityRepositoryProvider));
});


// --- ViewModel provider (stream-based) ---
final activityViewModelProvider =
StateNotifierProvider<ActivityViewModel, AsyncValue<List<ActivityEntity>>>((ref) {
  return ActivityViewModel.streamBased(
    activityStream: ref.watch(activityRepositoryProvider).watchActivityEntries(),
    addActivityEntry: ref.watch(addActivityEntryProvider),
    getActivityEntry: ref.watch(getActivityEntriesProvider),
  );
});


// --- Optional raw stream provider ---
final activityStreamProvider = StreamProvider<List<ActivityEntity>>((ref) {
  return ref.watch(activityRepositoryProvider).watchActivityEntries();
});
