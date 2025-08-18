import 'package:sqflite/sqflite.dart';
import 'package:bloom_health_app/features/bloom/domain/entities/activity_entity.dart';

/// Abstract local data source
abstract class ActivityLocalDataSource {
  Future<void> insertActivity(ActivityEntity entry);
  Future<List<ActivityEntity>> fetchActivities({DateTime? from, DateTime? to});
}

/// Implementation
class ActivityLocalDataSourceImpl implements ActivityLocalDataSource {
  final Database db;

  ActivityLocalDataSourceImpl({required this.db});

  @override
  Future<void> insertActivity(ActivityEntity entry) async {
    await db.insert(
      'activity',
      {
        'timestamp': entry.dateTime.toIso8601String(),
        'exerciseMin': entry.exerciseMin,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<ActivityEntity>> fetchActivities({DateTime? from, DateTime? to}) async {
    final results = await db.query(
      'activity',
      where: (from != null && to != null)
          ? 'timestamp BETWEEN ? AND ?'
          : null,
      whereArgs: (from != null && to != null)
          ? [from.toIso8601String(), to.toIso8601String()]
          : null,
      orderBy: 'timestamp ASC',
    );

    return results.map((row) {
      return ActivityEntity(
        dateTime: DateTime.parse(row['timestamp'] as String),
        exerciseMin: row['exerciseMin'] as int,
      );
    }).toList();
  }
}
