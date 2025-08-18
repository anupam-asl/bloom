import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloom_health_app/features/bloom/data/datasources/glucose_local_data_source.dart';
import 'package:bloom_health_app/features/bloom/data/repositories/glucose_repository_impl.dart';
import 'package:bloom_health_app/features/bloom/domain/repositories/glucose_repository.dart';
import 'package:bloom_health_app/features/bloom/domain/usecases/glucose_usecases/get_glucose_entries.dart';
import 'package:bloom_health_app/features/bloom/presentation/viewmodels/glucose_viewmodel.dart';
import 'package:sqflite/sqflite.dart';

import 'package:bloom_health_app/features/bloom/domain/entities/glucose_entity.dart';

import 'package:bloom_health_app/features/bloom/domain/usecases/glucose_usecases/add_glucose_entry_usecase.dart';

import 'package:bloom_health_app/core/db/database_provider.dart';

// --- DataSource provider ---
final glucoseLocalDataSourceProvider = Provider<GlucoseLocalDataSource>((ref) {
  return GlucoseLocalDataSourceImpl(db: ref.watch(databaseProvider));
});


// --- Repository provider ---
final glucoseRepositoryProvider = Provider<GlucoseRepository>((ref) {
  return GlucoseRepositoryImpl(localDataSource: ref.watch(glucoseLocalDataSourceProvider));
});


// --- UseCase provider ---
final getGlucoseEntriesProvider = Provider<GetGlucoseEntries>((ref) {
  return GetGlucoseEntries(ref.watch(glucoseRepositoryProvider));
});

final addGlucoseEntryProvider = Provider<AddGlucoseEntry>((ref) {
  return AddGlucoseEntry(ref.watch(glucoseRepositoryProvider));
});


// --- ViewModel provider (stream-based) ---
final glucoseViewModelProvider =
StateNotifierProvider<GlucoseViewModel, AsyncValue<List<GlucoseEntity>>>(
      (ref) {
    return GlucoseViewModel.streamBased(
      glucoseStream: ref.watch(glucoseRepositoryProvider).watchGlucoseEntries(),
      addGlucoseEntry: ref.watch(addGlucoseEntryProvider),
      getGlucoseEntry: ref.watch(getGlucoseEntriesProvider),

    );
  },
);

final glucoseStreamProvider = StreamProvider<List<GlucoseEntity>>((ref) {
  return ref.watch(glucoseRepositoryProvider).watchGlucoseEntries();
});


