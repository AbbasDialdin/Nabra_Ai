import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  // اسم الجدول
  static const String tableName = 'analysis_history';

  // تهيئة القاعدة
  static Future<Database> initDb() async {
    if (_database != null) return _database!;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'analysis_history.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT,
            input TEXT,
            result TEXT,
            datetime TEXT
          )
        ''');
      },
    );

    return _database!;
  }

  /// إضافة تحليل جديد
  static Future<void> insertAnalysis({
    required String type, // text / image / group
    required String input, // النص أو مسار الصورة
    required String result, // النتيجة (المشاعر)
    required String datetime, // التاريخ بصيغة ISO
  }) async {
    final db = await initDb();
    await db.insert(tableName, {
      'type': type,
      'input': input,
      'result': result,
      'datetime': datetime,
    });
  }

  /// جلب جميع التحليلات
  static Future<List<Map<String, dynamic>>> getAllAnalysis() async {
    final db = await initDb();
    return db.query(tableName, orderBy: 'datetime DESC');
  }

  /// حذف كل السجل
  static Future<void> deleteAll() async {
    final db = await initDb();
    await db.delete(tableName);
  }
}
