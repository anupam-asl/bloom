import 'package:sqflite/sqflite.dart';
import 'package:bloom_health_app/features/bloom/domain/entities/food_entity.dart';

/// Abstract
abstract class FoodLocalDataSource {
  Future<void> insertFood(FoodEntity entry);
  Future<List<FoodEntity>> fetchFood({DateTime? from, DateTime? to});
}

/// Implementation
class FoodLocalDataSourceImpl implements FoodLocalDataSource {
  final Database db;

  FoodLocalDataSourceImpl({required this.db});

  @override
  Future<void> insertFood(FoodEntity entry) async {
    await db.insert(
      'food',
      {
        'timestamp': entry.dateTime.toIso8601String(),
        'foodName': entry.foodname,
        'calories': entry.calorie,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<FoodEntity>> fetchFood({DateTime? from, DateTime? to}) async {
    final results = await db.query(
      'food',
      where: (from != null && to != null)
          ? 'timestamp BETWEEN ? AND ?'
          : null,
      whereArgs: (from != null && to != null)
          ? [from.toIso8601String(), to.toIso8601String()]
          : null,
      orderBy: 'timestamp ASC',
    );

    return results.map((row) {
      return FoodEntity(
        dateTime: DateTime.parse(row['timestamp'] as String),
        foodname: row['foodName'] as String,
        calorie: row['calories'] as double,
      );
    }).toList();
  }
}
