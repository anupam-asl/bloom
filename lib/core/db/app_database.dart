import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static Database? _db;

  // Singleton getter
  static Future<Database> get database async {
    if (_db != null) return _db!; // already open → just return

    _db = await _initDB();
    return _db!;
  }

  // Actual DB creation
  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'bloom_health.db');

    return await openDatabase(
      path,
      version: 4,
      onCreate: (db, version) async {
// Glucose table
        await db.execute('''
          CREATE TABLE glucose (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp TEXT NOT NULL,
            valueMgDl INTEGER NOT NULL
          )
        ''');

        // Food table
        await db.execute('''
          CREATE TABLE food (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp TEXT NOT NULL,
            foodName TEXT NOT NULL,
            calories REAL NOT NULL,
            protein REAL,
            carbohydrate REAL,
            totalFat REAL,
            saturatedFat REAL,
            transFat REAL,
            sodium REAL,
            cholesterol REAL,
            inputMode TEXT,
            expectedGlucoseResponse TEXT
          )
        ''');

        // Sleep table
        await db.execute('''
          CREATE TABLE sleep (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp TEXT,
            sleepState TEXT NOT NULL,
            heartRate INTEGER
          )
        ''');

        // Activities table (placeholder)
        await db.execute('''
          CREATE TABLE activity (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp TEXT NOT NULL,
            exerciseMin INTEGER NOT NULL
          )
        ''');
      },

    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 5) {
        // Drop old table if it exists
        await db.execute('DROP TABLE IF EXISTS activities');

        // Recreate with new name + schema
        await db.execute('''
            CREATE TABLE activity (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              timestamp TEXT NOT NULL,
              type TEXT NOT NULL,
              durationMinutes INTEGER,
              caloriesBurned REAL
            )
          ''');
      }
    }
    );

  }
}
