import 'package:sqflite/sqflite.dart';
import 'package:bloom_health_app/features/bloom/domain/entities/glucose_entity.dart';

/// Abstract local data source
abstract class GlucoseLocalDataSource {
  Future<void> insertGlucose(GlucoseEntity entry);
  Future<List<GlucoseEntity>> fetchGlucose({DateTime? from, DateTime? to});
}

/// Implementation
class GlucoseLocalDataSourceImpl implements GlucoseLocalDataSource {
  final Database db;

  GlucoseLocalDataSourceImpl({required this.db});

  @override
  Future<void> insertGlucose(GlucoseEntity entry) async {
    await db.insert(
      'glucose',
      {
        'timestamp': entry.dateTime.toIso8601String(),
        'valueMgDl': entry.valueMgDl,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<GlucoseEntity>> fetchGlucose({DateTime? from, DateTime? to}) async {
    final results = await db.query(
      'glucose',
      where: (from != null && to != null)
          ? 'timestamp BETWEEN ? AND ?'
          : null,
      whereArgs: (from != null && to != null)
          ? [from.toIso8601String(), to.toIso8601String()]
          : null,
      orderBy: 'timestamp ASC',
    );

    return results.map((row) {
      return GlucoseEntity(
        dateTime: DateTime.parse(row['timestamp'] as String),
        valueMgDl: row['valueMgDl'] as int,
      );
    }).toList();
  }
}
