import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloom_health_app/features/bloom/domain/entities/sleep_entity.dart';
import 'package:bloom_health_app/features/bloom/domain/usecases/sleep_usecases/add_sleep_entry.dart';
import 'package:bloom_health_app/features/bloom/domain/usecases/sleep_usecases/get_sleep_entries.dart';
import 'package:bloom_health_app/features/bloom/presentation/viewmodels/sleep_viewmodel.dart';
import 'package:bloom_health_app/features/bloom/domain/repositories/sleep_repository.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/datasources/sleep_local_data_source.dart';
import '../../data/repositories/sleep_repository_impl.dart';
import 'package:bloom_health_app/core/db/database_provider.dart';


final sleepLocalDataSourceProvider = Provider<SleepLocalDataSource>((ref) {
  return SleepLocalDataSourceImpl(db: ref.watch(databaseProvider));
});

// Repository provider
final sleepRepositoryProvider = Provider<SleepRepository>((ref) {
  return SleepRepositoryImpl(localDataSource: ref.watch(sleepLocalDataSourceProvider));
});


// Usecase providers
final addSleepEntryProvider = Provider<AddSleepEntry>((ref) {
  return AddSleepEntry(ref.watch(sleepRepositoryProvider));
});

final getSleepEntriesProvider = Provider<GetSleepEntries>((ref) {
  return GetSleepEntries(ref.watch(sleepRepositoryProvider));
});

// ViewModel provider (stream-based)
final sleepViewModelProvider =
StateNotifierProvider<SleepViewModel, AsyncValue<List<SleepEntity>>>((ref) {
  return SleepViewModel.streamBased(
    sleepStream: ref.watch(sleepRepositoryProvider).watchSleepEntries(),
    addSleepEntry: ref.watch(addSleepEntryProvider),
    getSleepEntries: ref.watch(getSleepEntriesProvider),
  );
});
