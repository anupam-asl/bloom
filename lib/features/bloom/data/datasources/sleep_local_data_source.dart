import 'package:sqflite/sqflite.dart';
import 'package:bloom_health_app/features/bloom/domain/entities/sleep_entity.dart';

abstract class SleepLocalDataSource {
  Future<void> insertSleep(SleepEntity entry);
  Future<List<SleepEntity>> fetchSleep({DateTime? from, DateTime? to});
}

class SleepLocalDataSourceImpl implements SleepLocalDataSource {
  final Database db;

  SleepLocalDataSourceImpl({required this.db});

  @override
  Future<void> insertSleep(SleepEntity entry) async {
    await db.insert(
      'sleep',
      {
        'timestamp': entry.dateTime,
        'sleepState': entry.sleepState,
        'heartRate': entry.heartRate,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  @override
  Future<List<SleepEntity>> fetchSleep({DateTime? from, DateTime? to}) async {
    final results = await db.query(
      'sleep',
      where: (from != null && to != null)
          ? 'timestamp BETWEEN ? AND ?'
          : null,
      whereArgs: (from != null && to != null)
          ? [from.toIso8601String(), to.toIso8601String()]
          : null,
      orderBy: 'timestamp ASC',
    );

    return results.map((row) {
      return SleepEntity(
        dateTime: row['timestamp'] as String,
        sleepState: row['sleepState'] as String,
        heartRate: row['heartRate'] as int,
      );
    }).toList();
  }

}
